package ai.arena.mobile;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.StatFs;
import android.provider.Settings;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.core.content.FileProvider;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.util.Locale;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * Background self-updater backed by GitHub Releases.
 *
 * Behaviour:
 * <ul>
 *   <li>checks at most once every 24 hours (and only once per app process), so normal
 *       browsing never burns the unauthenticated GitHub API quota;</li>
 *   <li>ignores drafts and pre-releases, and remembers versions the user skipped;</li>
 *   <li>downloads with a percentage indicator and a cancel button;</li>
 *   <li>verifies SHA-256, package name, version code and signing certificate before
 *       handing the file to the package installer (see {@link UpdateVerifier}).</li>
 * </ul>
 *
 * The update UI is limited to the transient system AlertDialogs that already existed;
 * no permanent chrome is added to the Arena web interface.
 */
public class AppUpdateManager {

    public static final String GITHUB_LATEST_RELEASE_URL =
            "https://api.github.com/repos/Mr-Nobody-Anonymous/arena-ai-android/releases/latest";

    private static final String PREFS_NAME = "arena_updates";
    private static final String KEY_LAST_CHECK = "last_check";
    private static final String KEY_SKIPPED_VERSION = "skipped_version";
    private static final long CHECK_INTERVAL_MS = 24L * 60L * 60L * 1000L;
    private static final int MAX_RELEASE_NOTES_CHARS = 1200;

    private static final ExecutorService updateExecutor = Executors.newSingleThreadExecutor();
    private static final Handler mainHandler = new Handler(Looper.getMainLooper());
    private static final AtomicBoolean checking = new AtomicBoolean(false);
    private static final AtomicBoolean downloading = new AtomicBoolean(false);

    private static volatile boolean promptShownThisSession = false;
    private static volatile boolean cancelled = false;
    private static volatile HttpURLConnection activeConnection = null;
    private static File pendingApkInstall = null;

    private AppUpdateManager() {
    }

    /**
     * Checks GitHub for a newer release and, if one exists, offers to install it.
     * Safe to call on every page load: the throttle makes it a no-op most of the time.
     */
    public static void checkForUpdates(Activity activity) {
        if (activity == null || activity.isFinishing()) {
            return;
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1 && activity.isDestroyed()) {
            return;
        }

        final Context appContext = activity.getApplicationContext();
        final SharedPreferences prefs = appContext.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        long lastCheck = prefs.getLong(KEY_LAST_CHECK, 0L);
        long now = System.currentTimeMillis();
        if (now - lastCheck < CHECK_INTERVAL_MS) {
            return;
        }
        if (promptShownThisSession) {
            return;
        }
        if (!checking.compareAndSet(false, true)) {
            return;
        }

        updateExecutor.execute(() -> {
            try {
                // Record the attempt even if it fails, so a flaky network cannot make
                // every page load hammer the unauthenticated GitHub API.
                prefs.edit().putLong(KEY_LAST_CHECK, now).apply();

                String json = fetchText(GITHUB_LATEST_RELEASE_URL);
                if (json == null) {
                    return;
                }

                JSONObject release = new JSONObject(json);
                if (release.optBoolean("draft", false) || release.optBoolean("prerelease", false)) {
                    return;
                }

                final String tagName = release.optString("tag_name", "");
                final String installedVersion = installedVersionName(appContext);
                if (!isNewerVersion(installedVersion, tagName)) {
                    return;
                }
                String skipped = prefs.getString(KEY_SKIPPED_VERSION, "");
                if (skipped != null && skipped.equalsIgnoreCase(tagName)) {
                    return;
                }

                String apkUrl = null;
                String apkName = null;
                String sumsUrl = null;
                String assetDigest = null;
                long apkSize = 0L;

                JSONArray assets = release.optJSONArray("assets");
                if (assets != null) {
                    for (int i = 0; i < assets.length(); i++) {
                        JSONObject asset = assets.optJSONObject(i);
                        if (asset == null) {
                            continue;
                        }
                        String name = asset.optString("name", "");
                        if (apkUrl == null && name.toLowerCase(Locale.US).endsWith(".apk")) {
                            apkUrl = asset.optString("browser_download_url", null);
                            apkName = name;
                            apkSize = asset.optLong("size", 0L);
                            assetDigest = asset.optString("digest", null);
                        } else if (sumsUrl == null && name.equalsIgnoreCase("SHA256SUMS")) {
                            sumsUrl = asset.optString("browser_download_url", null);
                        }
                    }
                }
                if (apkUrl == null) {
                    return;
                }

                // Prefer the published checksum file; fall back to GitHub's asset digest.
                String expectedSha256 = null;
                if (sumsUrl != null) {
                    String sums = fetchText(sumsUrl);
                    expectedSha256 = findShaForFile(sums, apkName);
                }
                if (expectedSha256 == null && assetDigest != null) {
                    String digest = assetDigest.trim();
                    if (digest.toLowerCase(Locale.US).startsWith("sha256:")) {
                        expectedSha256 = digest.substring("sha256:".length()).trim();
                    }
                }

                final String finalApkUrl = apkUrl;
                final long finalSize = apkSize;
                final String finalSha = expectedSha256;
                final String finalTag = tagName;
                final String notes = sanitizeReleaseNotes(release.optString("body", ""));

                mainHandler.post(() -> {
                    if (activity.isFinishing()
                            || (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1 && activity.isDestroyed())) {
                        return;
                    }
                    if (promptShownThisSession) {
                        return;
                    }
                    promptShownThisSession = true;
                    showUpdatePrompt(activity, finalTag, finalApkUrl, finalSize, finalSha, notes);
                });
            } catch (Exception ignored) {
                // A background update check must never interrupt the user.
            } finally {
                checking.set(false);
            }
        });
    }

    private static void showUpdatePrompt(Activity activity, String tagName, String downloadUrl,
                                         long sizeBytes, String expectedSha256, String releaseNotes) {
        StringBuilder message = new StringBuilder(
                activity.getString(R.string.update_available_message, tagName));
        if (sizeBytes > 0) {
            message.append('\n')
                    .append(activity.getString(R.string.update_size, sizeBytes / (1024.0 * 1024.0)));
        }
        if (releaseNotes != null && !releaseNotes.isEmpty()) {
            message.append("\n\n").append(releaseNotes);
        }
        message.append("\n\n").append(activity.getString(R.string.update_prompt));

        new AlertDialog.Builder(activity)
                .setTitle(R.string.update_available_title)
                .setMessage(message.toString())
                .setPositiveButton(R.string.update_now,
                        (dialog, which) -> startDownload(activity, tagName, downloadUrl, sizeBytes, expectedSha256))
                .setNegativeButton(R.string.update_later, (dialog, which) -> dialog.dismiss())
                .setNeutralButton(R.string.update_skip, (dialog, which) -> skipVersion(activity, tagName))
                .setCancelable(true)
                .show();
    }

    private static void skipVersion(Context context, String tagName) {
        context.getApplicationContext()
                .getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
                .edit()
                .putString(KEY_SKIPPED_VERSION, tagName)
                .apply();
    }

    private static void startDownload(Activity activity, String tagName, String downloadUrl,
                                      long sizeBytes, String expectedSha256) {
        if (activity == null || activity.isFinishing()) {
            return;
        }
        if (!downloading.compareAndSet(false, true)) {
            Toast.makeText(activity, R.string.update_download_in_progress, Toast.LENGTH_SHORT).show();
            return;
        }
        cancelled = false;

        final AlertDialog progressDialog = new AlertDialog.Builder(activity)
                .setTitle(R.string.update_downloading_title)
                .setMessage(R.string.update_downloading_preparing)
                .setNegativeButton(R.string.update_cancel, (dialog, which) -> {
                    cancelled = true;
                    disconnectActiveConnection();
                })
                .setCancelable(false)
                .create();
        progressDialog.show();

        final File cacheRoot = activity.getCacheDir();
        updateExecutor.execute(() -> {
            File finalFile = null;
            boolean cancelledByUser = false;
            Integer failureString = null;
            UpdateVerifier.Result verification = null;

            try {
                File updatesDir = new File(cacheRoot, "updates");
                if (!updatesDir.exists() && !updatesDir.mkdirs()) {
                    throw new IOException("Cannot create update directory");
                }
                finalFile = new File(updatesDir, "ArenaAI-" + sanitizeTag(tagName) + ".apk");
                File tempFile = new File(updatesDir, finalFile.getName() + ".part");
                if (tempFile.exists() && !tempFile.delete()) {
                    throw new IOException("Cannot replace previous download");
                }

                if (sizeBytes > 0) {
                    StatFs statFs = new StatFs(updatesDir.getAbsolutePath());
                    long available = statFs.getAvailableBytes();
                    if (available < sizeBytes * 2) {
                        failureString = R.string.update_no_space;
                    }
                }

                if (failureString == null) {
                    HttpURLConnection connection = openConnectionWithRedirects(downloadUrl);
                    activeConnection = connection;
                    long total = 0L;
                    int lastProgress = -1;
                    MessageDigest digest = MessageDigest.getInstance("SHA-256");

                    try (InputStream in = connection.getInputStream();
                         OutputStream out = new FileOutputStream(tempFile)) {
                        byte[] buffer = new byte[16 * 1024];
                        int read;
                        while ((read = in.read(buffer)) != -1) {
                            if (cancelled) {
                                cancelledByUser = true;
                                break;
                            }
                            out.write(buffer, 0, read);
                            digest.update(buffer, 0, read);
                            total += read;

                            if (sizeBytes > 0) {
                                int percent = (int) Math.min(100, (total * 100) / sizeBytes);
                                if (percent >= lastProgress + 2) {
                                    lastProgress = percent;
                                    final int shownPercent = percent;
                                    mainHandler.post(() -> {
                                        if (progressDialog.isShowing() && !activity.isFinishing()) {
                                            progressDialog.setMessage(activity.getString(
                                                    R.string.update_downloading_message, tagName, shownPercent));
                                        }
                                    });
                                }
                            }
                        }
                        out.flush();
                    } finally {
                        try {
                            connection.disconnect();
                        } catch (Exception ignored) {
                        }
                        activeConnection = null;
                    }

                    if (!cancelledByUser) {
                        if (total <= 0) {
                            failureString = R.string.update_download_failed;
                        } else {
                            String streamedSha = toHex(digest.digest());
                            if (!tempFile.renameTo(finalFile)) {
                                copyFile(tempFile, finalFile);
                                tempFile.delete();
                            }
                            verification = UpdateVerifier.verify(activity, finalFile, expectedSha256);
                            if (verification.ok() && expectedSha256 != null
                                    && !expectedSha256.equalsIgnoreCase(streamedSha)) {
                                // Belt and braces: the re-read hash is authoritative, but
                                // flag a stream that did not match what was written.
                                verification = new UpdateVerifier.Result(
                                        UpdateVerifier.Reason.HASH_MISMATCH, "stream mismatch");
                            }
                        }
                    }
                }
            } catch (Exception e) {
                cancelledByUser = cancelled;
                if (!cancelledByUser) {
                    failureString = R.string.update_download_failed;
                }
            } finally {
                disconnectActiveConnection();
            }

            final File downloadedFile = finalFile;
            final boolean userCancelled = cancelledByUser;
            final Integer failure = failureString;
            final UpdateVerifier.Result result = verification;

            mainHandler.post(() -> {
                downloading.set(false);
                try {
                    if (progressDialog.isShowing()) {
                        progressDialog.dismiss();
                    }
                } catch (Exception ignored) {
                }

                if (activity.isFinishing()) {
                    return;
                }

                if (userCancelled) {
                    deleteQuietly(downloadedFile);
                    Toast.makeText(activity, R.string.update_cancelled, Toast.LENGTH_SHORT).show();
                    return;
                }
                if (failure != null) {
                    deleteQuietly(downloadedFile);
                    Toast.makeText(activity, failure, Toast.LENGTH_LONG).show();
                    return;
                }
                if (result == null || !result.ok()) {
                    deleteQuietly(downloadedFile);
                    showVerificationFailure(activity, result);
                    return;
                }
                installApk(activity, downloadedFile);
            });
        });
    }

    private static void showVerificationFailure(Activity activity, UpdateVerifier.Result result) {
        if (activity == null || activity.isFinishing()) {
            return;
        }
        int reasonRes;
        UpdateVerifier.Reason reason = result == null ? UpdateVerifier.Reason.PARSE_ERROR : result.reason;
        switch (reason) {
            case MISSING_HASH:
                reasonRes = R.string.update_reason_missing_hash;
                break;
            case HASH_MISMATCH:
                reasonRes = R.string.update_reason_hash;
                break;
            case PACKAGE_MISMATCH:
                reasonRes = R.string.update_reason_package;
                break;
            case VERSION_DOWNGRADE:
                reasonRes = R.string.update_reason_version;
                break;
            case SIGNER_MISMATCH:
                reasonRes = R.string.update_reason_signer;
                break;
            default:
                reasonRes = R.string.update_reason_parse;
                break;
        }
        new AlertDialog.Builder(activity)
                .setTitle(R.string.update_verification_failed_title)
                .setMessage(activity.getString(R.string.update_verification_failed_message,
                        activity.getString(reasonRes)))
                .setPositiveButton(R.string.dialog_ok, (dialog, which) -> dialog.dismiss())
                .setCancelable(true)
                .show();
    }

    /**
     * Launches Android's package installer for the verified APK through FileProvider.
     */
    public static void installApk(Activity activity, File apkFile) {
        if (activity == null || apkFile == null || !apkFile.exists()) {
            return;
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O
                && !activity.getPackageManager().canRequestPackageInstalls()) {
            pendingApkInstall = apkFile;
            Toast.makeText(activity, R.string.update_install_permission, Toast.LENGTH_LONG).show();
            try {
                Intent intent = new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES);
                intent.setData(Uri.parse("package:" + activity.getPackageName()));
                activity.startActivity(intent);
            } catch (Exception e) {
                try {
                    activity.startActivity(new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES));
                } catch (Exception ignored) {
                    Toast.makeText(activity, R.string.update_install_permission, Toast.LENGTH_LONG).show();
                }
            }
            return;
        }

        try {
            Uri apkUri = FileProvider.getUriForFile(
                    activity,
                    activity.getPackageName() + ".fileprovider",
                    apkFile
            );

            Intent installIntent = new Intent(Intent.ACTION_VIEW);
            installIntent.setDataAndType(apkUri, "application/vnd.android.package-archive");
            installIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            installIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            activity.startActivity(installIntent);
        } catch (Exception e) {
            Toast.makeText(activity,
                    activity.getString(R.string.update_install_failed, String.valueOf(e.getMessage())),
                    Toast.LENGTH_LONG).show();
        }
    }

    /**
     * Resumes a deferred install after the user returns from the "install unknown apps"
     * settings screen.
     */
    public static void checkPendingInstall(Activity activity) {
        if (activity == null || pendingApkInstall == null) {
            return;
        }
        boolean canInstall = Build.VERSION.SDK_INT < Build.VERSION_CODES.O
                || activity.getPackageManager().canRequestPackageInstalls();
        if (!canInstall) {
            return;
        }
        File apk = pendingApkInstall;
        pendingApkInstall = null;
        if (apk.exists()) {
            installApk(activity, apk);
        }
    }

    // ---------------------------------------------------------------------------------
    // Networking
    // ---------------------------------------------------------------------------------

    private static String fetchText(String url) {
        HttpURLConnection connection = null;
        try {
            connection = (HttpURLConnection) new URL(url).openConnection();
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(8000);
            connection.setReadTimeout(15000);
            connection.setRequestProperty("Accept", "application/vnd.github+json");
            connection.setRequestProperty("X-GitHub-Api-Version", "2022-11-28");
            connection.setRequestProperty("User-Agent", "ArenaAI-Mobile-Client");

            int code = connection.getResponseCode();
            if (code != HttpURLConnection.HTTP_OK) {
                return null;
            }
            StringBuilder builder = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(connection.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    builder.append(line).append('\n');
                }
            }
            return builder.toString();
        } catch (Exception e) {
            return null;
        } finally {
            if (connection != null) {
                try {
                    connection.disconnect();
                } catch (Exception ignored) {
                }
            }
        }
    }

    /**
     * Opens a connection and manually follows HTTP 301/302/307/308 redirects
     * (GitHub release assets redirect to a signed S3 URL).
     */
    private static HttpURLConnection openConnectionWithRedirects(String initialUrl) throws Exception {
        String currentUrl = initialUrl;
        for (int i = 0; i < 8; i++) {
            URL url = new URL(currentUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setInstanceFollowRedirects(true);
            connection.setConnectTimeout(15000);
            connection.setReadTimeout(30000);
            connection.setRequestProperty("User-Agent", "ArenaAI-Mobile-Client");
            connection.setRequestProperty("Accept", "application/vnd.android.package-archive");

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_MOVED_PERM
                    || responseCode == HttpURLConnection.HTTP_MOVED_TEMP
                    || responseCode == 307
                    || responseCode == 308) {
                String location = connection.getHeaderField("Location");
                connection.disconnect();
                if (location != null && !location.isEmpty()) {
                    currentUrl = location;
                    continue;
                }
            }
            return connection;
        }
        throw new IOException("Exceeded maximum redirects");
    }

    private static void disconnectActiveConnection() {
        HttpURLConnection connection = activeConnection;
        if (connection != null) {
            try {
                connection.disconnect();
            } catch (Exception ignored) {
            }
        }
        activeConnection = null;
    }

    // ---------------------------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------------------------

    static String findShaForFile(String sumsText, String fileName) {
        if (sumsText == null || fileName == null) {
            return null;
        }
        for (String line : sumsText.split("\\r?\\n")) {
            String trimmed = line.trim();
            if (trimmed.isEmpty()) {
                continue;
            }
            String[] parts = trimmed.split("\\s+", 2);
            if (parts.length != 2 || !parts[0].matches("[0-9a-fA-F]{64}")) {
                continue;
            }
            String listedName = parts[1].replaceFirst("^\\*", "").trim();
            if (listedName.equals(fileName) || listedName.endsWith("/" + fileName)) {
                return parts[0].toLowerCase(Locale.US);
            }
        }
        return null;
    }

    private static String sanitizeReleaseNotes(String body) {
        if (body == null) {
            return "";
        }
        String text = body
                .replaceAll("(?i)<br\\s*/?>", "\n")
                .replaceAll("(?i)</p>", "\n")
                .replaceAll("<[^>]+>", "")
                .replaceAll("[ \\t]+", " ")
                .replaceAll("\\n{3,}", "\n\n")
                .trim();
        if (text.length() > MAX_RELEASE_NOTES_CHARS) {
            text = text.substring(0, MAX_RELEASE_NOTES_CHARS).trim() + "…";
        }
        return text;
    }

    private static String sanitizeTag(String tagName) {
        if (tagName == null || tagName.trim().isEmpty()) {
            return "update";
        }
        return tagName.trim().replaceAll("[^A-Za-z0-9._-]", "_");
    }

    private static void copyFile(File source, File target) throws IOException {
        try (InputStream in = new FileInputStream(source);
             OutputStream out = new FileOutputStream(target)) {
            byte[] buffer = new byte[16 * 1024];
            int read;
            while ((read = in.read(buffer)) != -1) {
                out.write(buffer, 0, read);
            }
            out.flush();
        }
    }

    private static void deleteQuietly(File file) {
        if (file == null) {
            return;
        }
        try {
            if (file.exists()) {
                file.delete();
            }
        } catch (Exception ignored) {
        }
    }

    private static String toHex(byte[] bytes) {
        StringBuilder builder = new StringBuilder(bytes.length * 2);
        for (byte value : bytes) {
            builder.append(String.format(Locale.US, "%02x", value & 0xff));
        }
        return builder.toString();
    }

    private static String installedVersionName(Context context) {
        try {
            PackageInfo info = context.getPackageManager()
                    .getPackageInfo(context.getPackageName(), 0);
            if (info.versionName != null && !info.versionName.isEmpty()) {
                return info.versionName;
            }
        } catch (Exception ignored) {
        }
        return "1.0.3";
    }

    /**
     * Compares semantic versions (e.g. "1.0.1" vs "v1.0.2").
     * Returns true when {@code remoteVersion} is strictly greater than {@code currentVersion}.
     */
    public static boolean isNewerVersion(String currentVersion, String remoteVersion) {
        if (remoteVersion == null || remoteVersion.trim().isEmpty()) return false;
        if (currentVersion == null || currentVersion.trim().isEmpty()) return false;

        String cleanCurrent = currentVersion.trim().replaceAll("^[vV]", "");
        String cleanRemote = remoteVersion.trim().replaceAll("^[vV]", "");

        String[] currentParts = cleanCurrent.split("\\.");
        String[] remoteParts = cleanRemote.split("\\.");

        int maxLen = Math.max(currentParts.length, remoteParts.length);
        for (int i = 0; i < maxLen; i++) {
            int cPart = i < currentParts.length ? parseVersionPart(currentParts[i]) : 0;
            int rPart = i < remoteParts.length ? parseVersionPart(remoteParts[i]) : 0;
            if (rPart > cPart) {
                return true;
            } else if (rPart < cPart) {
                return false;
            }
        }
        return false;
    }

    private static int parseVersionPart(String part) {
        try {
            String digits = part.replaceAll("[^0-9]", "");
            return digits.isEmpty() ? 0 : Integer.parseInt(digits);
        } catch (Exception e) {
            return 0;
        }
    }
}
