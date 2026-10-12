package ai.arena.mobile;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.core.content.FileProvider;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Manages background checking, downloading, and installation of updates
 * from GitHub releases (Mr-Nobody-Anonymous/arena-ai-android).
 */
public class AppUpdateManager {

    public static final String GITHUB_LATEST_RELEASE_URL =
            "https://api.github.com/repos/Mr-Nobody-Anonymous/arena-ai-android/releases/latest";

    private static final ExecutorService updateExecutor = Executors.newSingleThreadExecutor();
    private static final Handler mainHandler = new Handler(Looper.getMainLooper());
    private static File pendingApkInstall = null;

    /**
     * Check if a newer version is available on GitHub in the background.
     * If found, prompts the user via a native dialog to download and install.
     */
    public static void checkForUpdates(Activity activity, String currentVersion) {
        if (activity == null || activity.isFinishing()) {
            return;
        }

        updateExecutor.execute(() -> {
            try {
                URL url = new URL(GITHUB_LATEST_RELEASE_URL);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setConnectTimeout(8000);
                conn.setReadTimeout(10000);
                conn.setRequestProperty("Accept", "application/vnd.github.v3+json");
                conn.setRequestProperty("User-Agent", "ArenaAI-Mobile-Client");

                int code = conn.getResponseCode();
                if (code != 200) {
                    conn.disconnect();
                    return;
                }

                BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                StringBuilder builder = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    builder.append(line);
                }
                reader.close();
                conn.disconnect();

                JSONObject releaseJson = new JSONObject(builder.toString());
                String tagName = releaseJson.optString("tag_name", "");
                String releaseNotes = releaseJson.optString("body", "");

                // Check if remote version is newer than current
                if (!isNewerVersion(currentVersion, tagName)) {
                    return;
                }

                // Locate the ArenaAI.apk asset
                String apkDownloadUrl = null;
                long apkSize = 0;
                JSONArray assets = releaseJson.optJSONArray("assets");
                if (assets != null) {
                    for (int i = 0; i < assets.length(); i++) {
                        JSONObject asset = assets.getJSONObject(i);
                        String name = asset.optString("name", "");
                        if (name.equalsIgnoreCase("ArenaAI.apk") || name.endsWith(".apk")) {
                            apkDownloadUrl = asset.optString("browser_download_url", null);
                            apkSize = asset.optLong("size", 0);
                            break;
                        }
                    }
                }

                if (apkDownloadUrl == null) {
                    return;
                }

                final String finalDownloadUrl = apkDownloadUrl;
                final String finalTagName = tagName;
                final long finalSize = apkSize;

                mainHandler.post(() -> {
                    if (activity.isFinishing() || (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1 && activity.isDestroyed())) {
                        return;
                    }
                    showUpdatePromptDialog(activity, finalTagName, finalDownloadUrl, finalSize);
                });

            } catch (Exception ignored) {
                // Background update check fails silently without interrupting the user
            }
        });
    }

    /**
     * Shows a clean native dialog prompting user to update.
     */
    private static void showUpdatePromptDialog(Activity activity, String tagName, String downloadUrl, long sizeBytes) {
        String sizeText = "";
        if (sizeBytes > 0) {
            double mb = sizeBytes / (1024.0 * 1024.0);
            sizeText = String.format("\nSize: %.2f MB", mb);
        }

        new AlertDialog.Builder(activity)
                .setTitle("Update Available")
                .setMessage("A new version of Arena AI (" + tagName + ") is available with fixes and updates." + sizeText + "\n\nWould you like to download and install this update?")
                .setPositiveButton("Update Now", (dialog, which) -> {
                    startDownloadAndInstall(activity, downloadUrl, tagName);
                })
                .setNegativeButton("Later", (dialog, which) -> dialog.dismiss())
                .setCancelable(true)
                .show();
    }

    /**
     * Downloads the APK in background and triggers the package installer.
     */
    private static void startDownloadAndInstall(Activity activity, String downloadUrl, String tagName) {
        AlertDialog progressDialog = new AlertDialog.Builder(activity)
                .setTitle("Downloading Update")
                .setMessage("Downloading Arena AI " + tagName + "...\nPlease wait.")
                .setCancelable(false)
                .create();
        progressDialog.show();

        updateExecutor.execute(() -> {
            File downloadedFile = null;
            boolean success = false;
            try {
                File cacheDir = new File(activity.getCacheDir(), "updates");
                if (!cacheDir.exists()) {
                    cacheDir.mkdirs();
                }
                downloadedFile = new File(cacheDir, "ArenaAI-update.apk");
                if (downloadedFile.exists()) {
                    downloadedFile.delete();
                }

                HttpURLConnection conn = openConnectionWithRedirects(downloadUrl);
                InputStream in = conn.getInputStream();
                FileOutputStream out = new FileOutputStream(downloadedFile);

                byte[] buffer = new byte[8192];
                int len;
                while ((len = in.read(buffer)) != -1) {
                    out.write(buffer, 0, len);
                }

                out.flush();
                out.close();
                in.close();
                conn.disconnect();

                success = downloadedFile.exists() && downloadedFile.length() > 0;
            } catch (Exception e) {
                success = false;
            }

            final boolean isSuccess = success;
            final File finalFile = downloadedFile;

            mainHandler.post(() -> {
                if (progressDialog.isShowing()) {
                    progressDialog.dismiss();
                }

                if (!isSuccess || finalFile == null || !finalFile.exists()) {
                    Toast.makeText(activity, "Download failed. Please check internet connection.", Toast.LENGTH_SHORT).show();
                    return;
                }

                installApk(activity, finalFile);
            });
        });
    }

    /**
     * Launches Android PackageInstaller for the downloaded APK using FileProvider.
     */
    public static void installApk(Activity activity, File apkFile) {
        if (activity == null || apkFile == null || !apkFile.exists()) {
            return;
        }

        // On Android 8.0+ (Oreo+), check if app is permitted to install unknown apps
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            if (!activity.getPackageManager().canRequestPackageInstalls()) {
                pendingApkInstall = apkFile;
                Toast.makeText(activity, "Please allow Arena AI to install updates, then return to complete.", Toast.LENGTH_LONG).show();
                try {
                    Intent intent = new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES);
                    intent.setData(Uri.parse("package:" + activity.getPackageName()));
                    activity.startActivity(intent);
                } catch (Exception e) {
                    // Fallback to generic settings if URI scheme unsupported
                    activity.startActivity(new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES));
                }
                return;
            }
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
            Toast.makeText(activity, "Could not open installer: " + e.getMessage(), Toast.LENGTH_LONG).show();
        }
    }

    /**
     * Checks if there is a pending install after returning from permission settings.
     */
    public static void checkPendingInstall(Activity activity) {
        if (activity == null || pendingApkInstall == null) {
            return;
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            if (activity.getPackageManager().canRequestPackageInstalls()) {
                File apk = pendingApkInstall;
                pendingApkInstall = null;
                installApk(activity, apk);
            }
        } else {
            File apk = pendingApkInstall;
            pendingApkInstall = null;
            installApk(activity, apk);
        }
    }

    /**
     * Opens connection and manually follows HTTP 301/302/307/308 redirects (e.g. AWS S3 redirects).
     */
    private static HttpURLConnection openConnectionWithRedirects(String initialUrl) throws Exception {
        String currentUrl = initialUrl;
        for (int i = 0; i < 8; i++) {
            URL url = new URL(currentUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setInstanceFollowRedirects(true);
            conn.setConnectTimeout(15000);
            conn.setReadTimeout(30000);
            conn.setRequestProperty("User-Agent", "ArenaAI-Mobile-Client");

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_MOVED_PERM
                    || responseCode == HttpURLConnection.HTTP_MOVED_TEMP
                    || responseCode == 307
                    || responseCode == 308) {
                String location = conn.getHeaderField("Location");
                conn.disconnect();
                if (location != null && !location.isEmpty()) {
                    currentUrl = location;
                    continue;
                }
            }
            return conn;
        }
        throw new Exception("Exceeded max redirects");
    }

    /**
     * Compares semantic versions (e.g., "1.0.1" vs "v1.0.2").
     * Returns true if remoteVersion is strictly greater than currentVersion.
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
