package ai.arena.mobile;

import android.app.Activity;
import android.app.DownloadManager;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Base64;
import android.webkit.CookieManager;
import android.webkit.URLUtil;
import android.webkit.WebView;
import android.widget.Toast;

import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.Locale;

/**
 * Turns WebView download requests into something the user can actually keep.
 *
 * The Arena web app produces three kinds of downloads:
 * <ul>
 *   <li>ordinary HTTPS links (model weights, exports, attachments) — queued with the
 *       platform {@link DownloadManager} so the notification shade shows progress and
 *       the request carries the user's Arena session cookies;</li>
 *   <li>{@code blob:} URLs created by client-side JavaScript (common for "Download"
 *       buttons on generated text/images) — resolved through the page's own Blob store
 *       and written to Downloads;</li>
 *   <li>{@code data:} URLs — decoded and written to Downloads.</li>
 * </ul>
 *
 * DownloadManager, MediaStore and the notification shade are system surfaces, so this
 * adds no app-specific UI on top of the Arena web interface.
 */
final class DownloadHandler {

    private static final int MAX_BLOB_DATA_URL_LENGTH = 64 * 1024 * 1024; // ~48 MB binary
    private static final int BLOB_POLL_INTERVAL_MS = 250;
    private static final int BLOB_POLL_ATTEMPTS = 120; // 30 seconds

    private static final Handler MAIN_HANDLER = new Handler(Looper.getMainLooper());
    private static volatile boolean blobDownloadInProgress = false;

    private DownloadHandler() {
    }

    static void handle(Activity activity, WebView source, String url, String userAgent,
                       String contentDisposition, String mimeType, long contentLength) {
        if (activity == null || url == null) {
            return;
        }
        String trimmed = url.trim();
        if (trimmed.isEmpty()) {
            return;
        }
        String lower = trimmed.toLowerCase(Locale.US);

        if (lower.startsWith("blob:")) {
            downloadBlob(activity, source, trimmed, mimeType, contentDisposition);
            return;
        }
        if (lower.startsWith("data:")) {
            downloadDataUri(activity, trimmed, mimeType, contentDisposition);
            return;
        }
        if (!lower.startsWith("http://") && !lower.startsWith("https://")) {
            openWithSystem(activity, Uri.parse(trimmed));
            return;
        }
        enqueueSystemDownload(activity, trimmed, userAgent, contentDisposition, mimeType);
    }

    // ---------------------------------------------------------------------------------
    // HTTPS downloads
    // ---------------------------------------------------------------------------------

    private static void enqueueSystemDownload(Activity activity, String url, String userAgent,
                                              String contentDisposition, String mimeType) {
        String fileName = sanitizeFileName(URLUtil.guessFileName(url, contentDisposition, mimeType));
        DownloadManager manager = (DownloadManager) activity.getSystemService(Context.DOWNLOAD_SERVICE);
        if (manager == null) {
            Toast.makeText(activity, R.string.download_no_manager, Toast.LENGTH_SHORT).show();
            openWithSystem(activity, Uri.parse(url));
            return;
        }

        try {
            DownloadManager.Request request = buildRequest(activity, url, userAgent, mimeType, fileName, true);
            manager.enqueue(request);
            Toast.makeText(activity, R.string.download_started, Toast.LENGTH_SHORT).show();
        } catch (Exception publicDirFailure) {
            try {
                DownloadManager.Request fallback = buildRequest(activity, url, userAgent, mimeType, fileName, false);
                manager.enqueue(fallback);
                Toast.makeText(activity, R.string.download_started, Toast.LENGTH_SHORT).show();
            } catch (Exception ignored) {
                Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
                openWithSystem(activity, Uri.parse(url));
            }
        }
    }

    private static DownloadManager.Request buildRequest(Activity activity, String url, String userAgent,
                                                        String mimeType, String fileName, boolean publicDir) {
        DownloadManager.Request request = new DownloadManager.Request(Uri.parse(url));

        String cookies = CookieManager.getInstance().getCookie(url);
        if (!TextUtils.isEmpty(cookies)) {
            request.addRequestHeader("Cookie", cookies);
        }
        String ua = userAgent;
        if (TextUtils.isEmpty(ua)) {
            ua = "Mozilla/5.0 (Linux; Android) AppleWebKit/537.36 (KHTML, like Gecko) Chrome Mobile Safari/537.36";
        }
        request.addRequestHeader("User-Agent", ua);

        if (!TextUtils.isEmpty(mimeType)) {
            request.setMimeType(mimeType);
        }
        request.setTitle(fileName);
        request.setDescription(activity.getString(R.string.download_notification_description));
        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
        request.setAllowedOverMetered(true);
        request.setAllowedOverRoaming(true);

        if (publicDir) {
            request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, fileName);
        } else {
            request.setDestinationInExternalFilesDir(activity, Environment.DIRECTORY_DOWNLOADS, fileName);
        }
        return request;
    }

    // ---------------------------------------------------------------------------------
    // data: URLs
    // ---------------------------------------------------------------------------------

    private static void downloadDataUri(Activity activity, String url, String mimeType,
                                        String contentDisposition) {
        try {
            int comma = url.indexOf(',');
            if (comma < 0) {
                Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
                return;
            }
            String header = url.substring(5, comma);
            String payload = url.substring(comma + 1);
            boolean isBase64 = header.toLowerCase(Locale.US).contains(";base64");
            String declaredMime = header.split(";")[0];

            String effectiveMime = !TextUtils.isEmpty(declaredMime)
                    ? declaredMime
                    : (!TextUtils.isEmpty(mimeType) ? mimeType : "application/octet-stream");

            byte[] bytes = isBase64
                    ? Base64.decode(payload, Base64.DEFAULT)
                    : Uri.decode(payload).getBytes(StandardCharsets.UTF_8);

            String fileName = sanitizeFileName(
                    URLUtil.guessFileName("arena-download", contentDisposition, effectiveMime));
            if (!fileName.contains(".")) {
                fileName = fileName + "." + extensionForMime(effectiveMime);
            }
            saveBytes(activity, bytes, effectiveMime, fileName);
        } catch (Exception e) {
            Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
        }
    }

    // ---------------------------------------------------------------------------------
    // blob: URLs
    // ---------------------------------------------------------------------------------

    private static void downloadBlob(Activity activity, WebView source, String blobUrl,
                                     String mimeType, String contentDisposition) {
        if (source == null) {
            return;
        }
        if (blobDownloadInProgress) {
            Toast.makeText(activity, R.string.download_in_progress, Toast.LENGTH_SHORT).show();
            return;
        }
        blobDownloadInProgress = true;

        String safeUrl = blobUrl.replace("\\", "\\\\").replace("'", "\\'");
        String script =
                "window.__arenaBlobState='PENDING';window.__arenaBlobData=null;window.__arenaBlobMime='';"
                        + "(function(){try{"
                        + "fetch('" + safeUrl + "').then(function(r){return r.blob();}).then(function(b){"
                        + "var fr=new FileReader();"
                        + "fr.onload=function(){window.__arenaBlobState='OK';window.__arenaBlobData=fr.result;"
                        + "window.__arenaBlobMime=b.type||'';};"
                        + "fr.onerror=function(){window.__arenaBlobState='ERROR';};"
                        + "fr.readAsDataURL(b);"
                        + "}).catch(function(){window.__arenaBlobState='ERROR';});"
                        + "}catch(e){window.__arenaBlobState='ERROR';}})();";

        try {
            source.evaluateJavascript(script, null);
        } catch (Exception e) {
            blobDownloadInProgress = false;
            Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
            return;
        }

        pollBlob(activity, source, mimeType, contentDisposition, 0);
    }

    private static void pollBlob(Activity activity, WebView source, String mimeType,
                                 String contentDisposition, int attempt) {
        if (attempt >= BLOB_POLL_ATTEMPTS || activity.isFinishing()) {
            blobDownloadInProgress = false;
            Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            source.evaluateJavascript("window.__arenaBlobState||'PENDING'", value -> {
                String state = asString(value);
                if ("OK".equals(state)) {
                    readBlobPayload(activity, source, mimeType, contentDisposition);
                } else if ("ERROR".equals(state)) {
                    blobDownloadInProgress = false;
                    Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
                } else {
                    MAIN_HANDLER.postDelayed(
                            () -> pollBlob(activity, source, mimeType, contentDisposition, attempt + 1),
                            BLOB_POLL_INTERVAL_MS);
                }
            });
        } catch (Exception e) {
            blobDownloadInProgress = false;
            Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
        }
    }

    private static void readBlobPayload(Activity activity, WebView source, String mimeType,
                                        String contentDisposition) {
        try {
            source.evaluateJavascript(
                    "window.__arenaBlobData+'\\u0000'+window.__arenaBlobMime",
                    value -> {
                        blobDownloadInProgress = false;
                        try {
                            String combined = asString(value);
                            if (combined == null || combined.isEmpty()) {
                                Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
                                return;
                            }
                            int separator = combined.lastIndexOf('\u0000');
                            String dataUrl = separator >= 0 ? combined.substring(0, separator) : combined;
                            String blobMime = separator >= 0 ? combined.substring(separator + 1) : "";

                            if (dataUrl.length() > MAX_BLOB_DATA_URL_LENGTH) {
                                Toast.makeText(activity, R.string.download_too_large, Toast.LENGTH_SHORT).show();
                                return;
                            }

                            int comma = dataUrl.indexOf(',');
                            if (comma < 0) {
                                Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
                                return;
                            }
                            String header = dataUrl.substring(0, comma);
                            String payload = dataUrl.substring(comma + 1);
                            boolean isBase64 = header.toLowerCase(Locale.US).contains(";base64");

                            String declaredMime = header.startsWith("data:")
                                    ? header.substring(5).split(";")[0]
                                    : "";
                            String effectiveMime = !TextUtils.isEmpty(blobMime)
                                    ? blobMime
                                    : (!TextUtils.isEmpty(declaredMime)
                                    ? declaredMime
                                    : (!TextUtils.isEmpty(mimeType) ? mimeType : "application/octet-stream"));

                            byte[] bytes = isBase64
                                    ? Base64.decode(payload, Base64.DEFAULT)
                                    : Uri.decode(payload).getBytes(StandardCharsets.UTF_8);

                            String fileName = sanitizeFileName(
                                    URLUtil.guessFileName("arena-download", contentDisposition, effectiveMime));
                            if (!fileName.contains(".")) {
                                fileName = fileName + "." + extensionForMime(effectiveMime);
                            }
                            saveBytes(activity, bytes, effectiveMime, fileName);
                        } catch (Exception e) {
                            Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
                        } finally {
                            try {
                                source.evaluateJavascript(
                                        "window.__arenaBlobData=null;window.__arenaBlobState='';window.__arenaBlobMime='';",
                                        null);
                            } catch (Exception ignored) {
                            }
                        }
                    });
        } catch (Exception e) {
            blobDownloadInProgress = false;
            Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
        }
    }

    private static String asString(String javascriptResult) {
        if (javascriptResult == null || "null".equals(javascriptResult)) {
            return null;
        }
        try {
            Object parsed = new JSONTokener(javascriptResult).nextValue();
            if (parsed instanceof String) {
                return (String) parsed;
            }
            if (parsed instanceof JSONObject) {
                return parsed.toString();
            }
            return String.valueOf(parsed);
        } catch (Exception e) {
            return javascriptResult;
        }
    }

    // ---------------------------------------------------------------------------------
    // Writing bytes
    // ---------------------------------------------------------------------------------

    private static void saveBytes(Activity activity, byte[] data, String mimeType, String fileName) {
        if (data == null || data.length == 0) {
            Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
            return;
        }
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                ContentValues values = new ContentValues();
                values.put(MediaStore.MediaColumns.DISPLAY_NAME, fileName);
                values.put(MediaStore.MediaColumns.MIME_TYPE, mimeType);
                values.put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS);
                values.put(MediaStore.MediaColumns.IS_PENDING, 1);

                Uri item = activity.getContentResolver()
                        .insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values);
                if (item == null) {
                    Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
                    return;
                }
                try (OutputStream out = activity.getContentResolver().openOutputStream(item)) {
                    if (out == null) {
                        throw new IllegalStateException("No output stream");
                    }
                    out.write(data);
                    out.flush();
                }
                values.clear();
                values.put(MediaStore.MediaColumns.IS_PENDING, 0);
                activity.getContentResolver().update(item, values, null, null);
                Toast.makeText(activity, R.string.download_saved, Toast.LENGTH_SHORT).show();
                return;
            }

            File dir = activity.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
            if (dir == null) {
                dir = activity.getFilesDir();
            }
            if (!dir.exists() && !dir.mkdirs()) {
                Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
                return;
            }
            File target = new File(dir, fileName);
            try (FileOutputStream out = new FileOutputStream(target)) {
                out.write(data);
                out.flush();
            }
            try {
                MediaScannerConnection.scanFile(activity,
                        new String[]{target.getAbsolutePath()}, new String[]{mimeType}, null);
            } catch (Exception ignored) {
            }
            Toast.makeText(activity, R.string.download_saved, Toast.LENGTH_SHORT).show();
        } catch (Exception e) {
            Toast.makeText(activity, R.string.download_failed, Toast.LENGTH_SHORT).show();
        }
    }

    // ---------------------------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------------------------

    private static String extensionForMime(String mimeType) {
        if (mimeType == null) {
            return "bin";
        }
        String extension = android.webkit.MimeTypeMap.getSingleton()
                .getExtensionFromMimeType(mimeType);
        return TextUtils.isEmpty(extension) ? "bin" : extension;
    }

    private static String sanitizeFileName(String candidate) {
        String name = candidate == null ? "" : candidate.trim();
        if (name.isEmpty()) {
            name = "arena-download";
        }
        // Strip directory separators and characters that are illegal on Android storage.
        name = name.replaceAll("[\\\\/:*?\"<>|\\p{Cntrl}]", "_");
        while (name.startsWith(".")) {
            name = name.substring(1);
        }
        if (name.isEmpty()) {
            name = "arena-download";
        }
        if (name.length() > 120) {
            String extension = "";
            int dot = name.lastIndexOf('.');
            if (dot > 0 && name.length() - dot <= 12) {
                extension = name.substring(dot);
            }
            name = name.substring(0, 120 - extension.length()) + extension;
        }
        return name;
    }

    private static void openWithSystem(Activity activity, Uri uri) {
        try {
            Intent intent = new Intent(Intent.ACTION_VIEW, uri);
            intent.addCategory(Intent.CATEGORY_BROWSABLE);
            activity.startActivity(intent);
        } catch (Exception e) {
            Toast.makeText(activity, R.string.external_link_unavailable, Toast.LENGTH_SHORT).show();
        }
    }
}
