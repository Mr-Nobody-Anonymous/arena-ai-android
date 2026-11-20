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
 *   <li><b>Daily background check:</b> {@link UpdateScheduler} schedules work on a 24-hour
 *       cadence (even when the app is closed) and {@link #checkForUpdatesInBackground(Context)}
 *       queries GitHub, then downloads and verifies a newer APK with no app UI at all.
 *       Opening the app hands the verified APK to Android's package installer — the closest
 *       Android allows to a self-update, since the OS always requires the user to confirm
 *       an install.</li>
 *   <li><b>Foreground check:</b> while the app is in use, {@link #checkForUpdates(Activity)}
 *       runs on launch, resume and page load, throttled to once every 6 hours (5-minute
 *       retry after a failure), so a release published during the day is offered promptly
 *       without burning the unauthenticated GitHub API quota;</li>
 *   <li>ignores drafts and pre-releases, and remembers versions the user skipped;</li>
 *   <li>foreground downloads show a percentage indicator and a cancel button;</li>
 *   <li>verifies SHA-256, package name, version code and signing certificate before
 *       handing the file to the package installer (see {@link UpdateVerifier}).</li>
 * </ul>
 *
 * The update UI uses only the transient system AlertDialogs that already existed; no
 * additional app UI or permanent chrome is added to the Arena web interface.
 */
public class AppUpdateManager {

    public static final String GITHUB_LATEST_RELEASE_URL =
            "https://api.github.com/repos/Mr-Nobody-Anonymous/arena-ai-android/releases/latest";

    private static final String PREFS_NAME = "arena_updates";
    private static final String KEY_LAST_CHECK = "last_check";
    private static final String KEY_LAST_CHECK_OK = "last_check_ok";
    private static final String KEY_SKIPPED_VERSION = "skipped_version";
    private static final String KEY_LAST_PROMPT_VERSION = "last_prompt_version";
    private static final String KEY_LAST_PROMPT_TIME = "last_prompt_time";
    private static final String KEY_ETAG = "etag";
    private static final String KEY_PENDING_APK_PATH = "pending_apk_path";
    private static final String KEY_PENDING_APK_VERSION = "pending_apk_version";
    private static final String KEY_LAST_INSTALL_PERMISSION_PROMPT = "last_install_permission_prompt";

    /**
     * Normal spacing between successful foreground checks. Short enough that a release
     * published while the app is in use shows up the next time the user navigates or
     * returns to the app, long enough that the unauthenticated GitHub API quota
     * (60 requests/hour) is never at risk. The scheduled daily check runs in the
     * background via {@link UpdateScheduler#INTERVAL_MS} (24 hours), even when the app
     * is closed (subject to Android's battery and connectivity scheduling).
     */
    private static final long CHECK_INTERVAL_MS = 6L * 60L * 60L * 1000L;
    /** After a failed check (offline, rate-limited, GitHub down) retry much sooner. */
    private static final long FAILURE_RETRY_MS = 5L * 60L * 1000L;
    /** The same release is offered at most once per this window, even across restarts. */
    private static final long PROMPT_COOLDOWN_MS = 12L * 60L * 60L * 1000L;
    /** Avoid reopening Android's unknown-app settings on every return to the app. */
    private static final long INSTALL_PERMISSION_PROMPT_COOLDOWN_MS = 24L * 60L * 60L * 1000L;
    private static final int MAX_RELEASE_NOTES_CHARS = 1200;
    /** Hard cap for the small text responses (release JSON, SHA256SUMS). */
    private static final int MAX_TEXT_RESPONSE_CHARS = 256 * 1024;
    /** How long a verified APK may wait for the user to confirm the install. */
    private static final long PENDING_APK_MAX_AGE_MS = 7L * 24L * 60L * 60L * 1000L;

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
        // A failed check must not silence the updater for a whole interval, but it must not
        // let every page load hit the API either.
        boolean lastCheckSucceeded = prefs.getBoolean(KEY_LAST_CHECK_OK, true);
        long interval = lastCheckSucceeded ? CHECK_INTERVAL_MS : FAILURE_RETRY_MS;
        if (now - lastCheck < interval) {
            return;
        }
        if (promptShownThisSession || downloading.get()) {
            return;
        }
        if (!checking.compareAndSet(false, true)) {
            return;
        }

        updateExecutor.execute(() -> {
            try {
                // Claim the slot before touching the network, so a flaky connection cannot
                // make every page load hammer the unauthenticated GitHub API.
                prefs.edit().putLong(KEY_LAST_CHECK, now).apply();

                String json = fetchText(GITHUB_LATEST_RELEASE_URL, prefs);
                if (json == null) {
                    prefs.edit().putBoolean(KEY_LAST_CHECK_OK, false).apply();
                    return;
                }
                if (json.isEmpty()) {
                    // 304 Not Modified: the release is unchanged since the last check.
                    prefs.edit().putBoolean(KEY_LAST_CHECK_OK, true).apply();
                    return;
                }

                JSONObject release = new JSONObject(json);
                prefs.edit().putBoolean(KEY_LAST_CHECK_OK, true).apply();
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

                String[] apk = findApkAsset(release);
                if (apk == null) {
                    return;
                }
                String apkUrl = apk[0];
                String apkName = apk[1];
                long apkSize = 0L;
                try {
                    apkSize = Long.parseLong(apk[2]);
                } catch (Exception ignored) {
                }
                String expectedSha256 = resolveExpectedSha256(release, apkName, apk[3]);

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
                    long promptedAt = prefs.getLong(KEY_LAST_PROMPT_TIME, 0L);
                    String promptedVersion = prefs.getString(KEY_LAST_PROMPT_VERSION, "");
                    long nowPrompt = System.currentTimeMillis();
                    if (finalTag.equalsIgnoreCase(promptedVersion)
                            && nowPrompt - promptedAt < PROMPT_COOLDOWN_MS) {
                        // "Later" means later, not on every restart.
                        return;
                    }
                    promptShownThisSession = true;
                    prefs.edit()
                            .putString(KEY_LAST_PROMPT_VERSION, finalTag)
                            .putLong(KEY_LAST_PROMPT_TIME, nowPrompt)
                            .apply();
                    showUpdatePrompt(activity, finalTag, finalApkUrl, finalSize, finalSha, notes);
                });
            } catch (Exception ignored) {
                // A background update check must never interrupt the user.
            } finally {
                checking.set(false);
            }
        });
    }

    /**
     * Daily background check (fired by {@link UpdateWorker} via
     * {@link UpdateScheduler}). Unlike the foreground check it never shows a dialog:
     * when a newer release exists it downloads and verifies the APK silently, then persists
     * it as the pending update. The next time the user opens the app,
     * {@link #checkPendingInstall(Activity)} hands the verified APK to the system installer
     * — the app updates itself with a single OS confirmation tap.
     *
     * <p>Skipped entirely when a verified APK is already pending, so the daily worker never
     * re-downloads the same release.</p>
     *
     * <p><b>Memory:</b> the work runs synchronously on the caller's thread (WorkManager's
     * worker thread), not on the shared foreground executor. Nothing is buffered in heap:
     * the API response is a few kilobytes of JSON, release notes are not parsed in the
     * background path, and the APK streams straight to disk through a single 16 KiB buffer
     * that is released as soon as the check returns. There is no latch, no extra thread and
     * no retained Activity or Context beyond the application context.</p>
     *
     * @return {@code true} when the check completed (with or without an update);
     *         {@code false} on a transient failure, so WorkManager can back off and retry.
     */
    static boolean checkForUpdatesInBackground(Context context) {
        if (context == null) {
            return true;
        }
        final Context appContext = context.getApplicationContext();
        if (hasPendingApk(appContext)) {
            // Nothing to do: a verified APK is already waiting for the installer.
            return true;
        }
        if (downloading.get() || !checking.compareAndSet(false, true)) {
            // A foreground check/download owns the updater; let it finish that work.
            return true;
        }

        try {
            SharedPreferences prefs =
                    appContext.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
            long now = System.currentTimeMillis();
            prefs.edit().putLong(KEY_LAST_CHECK, now).apply();

            String json = fetchText(GITHUB_LATEST_RELEASE_URL, prefs);
            if (json == null) {
                prefs.edit().putBoolean(KEY_LAST_CHECK_OK, false).apply();
                return false;
            }
            if (json.isEmpty()) {
                // 304 Not Modified: the release is unchanged since the last check.
                prefs.edit().putBoolean(KEY_LAST_CHECK_OK, true).apply();
                return true;
            }
            prefs.edit().putBoolean(KEY_LAST_CHECK_OK, true).apply();

            JSONObject release = new JSONObject(json);
            // Drop the response text before the download so only one buffer is live.
            json = null;
            if (release.optBoolean("draft", false) || release.optBoolean("prerelease", false)) {
                return true;
            }

            final String tagName = release.optString("tag_name", "");
            if (!isNewerVersion(installedVersionName(appContext), tagName)) {
                return true;
            }
            String skipped = prefs.getString(KEY_SKIPPED_VERSION, "");
            if (skipped != null && skipped.equalsIgnoreCase(tagName)) {
                return true;
            }

            String[] apk = findApkAsset(release);
            if (apk == null) {
                return true;
            }
            String expectedSha256 = resolveExpectedSha256(release, apk[1], apk[3]);

            // A failed download is retried by the next scheduled (or foreground) check,
            // not by an immediate WorkManager retry that would re-download right away.
            long expectedSize = 0L;
            try {
                expectedSize = Long.parseLong(apk[2]);
            } catch (Exception ignored) {
            }
            downloadSilently(appContext, tagName, apk[0], expectedSha256, expectedSize);
            return true;
        } catch (Exception ignored) {
            appContext.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
                    .edit().putBoolean(KEY_LAST_CHECK_OK, false).apply();
            // A background check must never crash the app or wake the user.
            return false;
        } finally {
            checking.set(false);
        }
    }

    /**
     * Downloads and verifies an update with no UI. On success the APK is persisted as the
     * pending update for installation when the user next opens the app; on any failure the
     * partial file is deleted and nothing is shown.
     *
     * <p>Memory stays flat regardless of APK size: the body is streamed to the cache
     * directory through a 16 KiB buffer and hashed in the same pass, so the APK is never
     * held in a {@code byte[]}. If the free-space check fails the download is skipped
     * entirely instead of filling the user's storage.</p>
     */
    private static void downloadSilently(Context context, String tagName, String downloadUrl,
                                         String expectedSha256, long expectedSize) {
        if (!downloading.compareAndSet(false, true)) {
            return;
        }
        File tempFile = null;
        File finalFile = null;
        try {
            File updatesDir = new File(context.getCacheDir(), "updates");
            if (!updatesDir.exists() && !updatesDir.mkdirs()) {
                return;
            }
            pruneStaleDownloads(context, updatesDir);
            finalFile = new File(updatesDir, "ArenaAI-" + sanitizeTag(tagName) + ".apk");
            tempFile = new File(updatesDir, finalFile.getName() + ".part");
            if (tempFile.exists() && !tempFile.delete()) {
                return;
            }
            if (expectedSize > 0) {
                long available = new StatFs(updatesDir.getAbsolutePath()).getAvailableBytes();
                if (available < expectedSize) {
                    // Not enough room for the APK: leave the installed version untouched
                    // and let a later check try again.
                    return;
                }
            }

            HttpURLConnection connection = openConnectionWithRedirects(downloadUrl);
            activeConnection = connection;
            long total = 0L;
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            try (InputStream in = connection.getInputStream();
                 OutputStream out = new FileOutputStream(tempFile)) {
                byte[] buffer = new byte[16 * 1024];
                int read;
                while ((read = in.read(buffer)) != -1) {
                    out.write(buffer, 0, read);
                    digest.update(buffer, 0, read);
                    total += read;
                }
                out.flush();
            } finally {
                try {
                    connection.disconnect();
                } catch (Exception ignored) {
                }
                activeConnection = null;
            }

            if (total <= 0) {
                deleteQuietly(tempFile);
                return;
            }
            String streamedSha = toHex(digest.digest());
            if (!tempFile.renameTo(finalFile)) {
                // crossFileSystem is not expected here (same directory), but a copy is
                // still safe because it is streamed, never buffered.
                copyFile(tempFile, finalFile);
                tempFile.delete();
            }
            tempFile = null;
            // The hash of the bytes that actually landed on disk is already known from the
            // streaming pass, so verify() is told to skip re-reading the whole APK.
            UpdateVerifier.Result verification =
                    UpdateVerifier.verify(context, finalFile, expectedSha256, streamedSha);
            if (!verification.ok()) {
                deleteQuietly(finalFile);
                finalFile = null;
                return;
            }

            SharedPreferences prefs =
                    context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
            prefs.edit()
                    .putString(KEY_PENDING_APK_PATH, finalFile.getAbsolutePath())
                    .putString(KEY_PENDING_APK_VERSION, tagName)
                    .apply();
            pendingApkInstall = finalFile;
        } catch (Exception ignored) {
            // Silent failure: the foreground check will retry on the next app launch.
            deleteQuietly(tempFile);
            deleteQuietly(finalFile);
        } finally {
            downloading.set(false);
            disconnectActiveConnection();
        }
    }

    /**
     * Keeps the update cache to at most one APK: removes leftovers from interrupted
     * downloads and APKs for other versions. The pending APK is preserved unless it has
     * been waiting for more than a week (for example, the user never granted the install
     * permission), so the cache directory cannot grow without bound.
     */
    private static void pruneStaleDownloads(Context context, File updatesDir) {
        File[] files = updatesDir.listFiles();
        if (files == null) {
            return;
        }
        SharedPreferences prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        File pending = null;
        String pendingPath = prefs.getString(KEY_PENDING_APK_PATH, null);
        if (pendingPath != null) {
            pending = new File(pendingPath);
        }
        long now = System.currentTimeMillis();
        for (File file : files) {
            String name = file.getName();
            if (!name.endsWith(".apk") && !name.endsWith(".part")) {
                continue;
            }
            if (name.endsWith(".part")) {
                // An interrupted download is never installable.
                deleteQuietly(file);
                continue;
            }
            boolean isPending = pending != null
                    && file.getAbsolutePath().equals(pending.getAbsolutePath());
            if (isPending) {
                if (now - file.lastModified() < PENDING_APK_MAX_AGE_MS) {
                    continue;
                }
                prefs.edit()
                        .remove(KEY_PENDING_APK_PATH)
                        .remove(KEY_PENDING_APK_VERSION)
                        .apply();
                pendingApkInstall = null;
            }
            deleteQuietly(file);
        }
    }

    /**
     * Whether a verified APK is already waiting to be installed. Reads the persisted path
     * so a background download survives process death and app restarts.
     */
    static boolean hasPendingApk(Context context) {
        if (context == null) {
            return false;
        }
        SharedPreferences prefs =
                context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        String path = prefs.getString(KEY_PENDING_APK_PATH, null);
        if (path == null || path.isEmpty()) {
            return false;
        }
        File file = new File(path);
        if (!file.exists() || file.length() == 0) {
            prefs.edit().remove(KEY_PENDING_APK_PATH).remove(KEY_PENDING_APK_VERSION).apply();
            return false;
        }
        String pendingVersion = prefs.getString(KEY_PENDING_APK_VERSION, null);
        if (pendingVersion != null
                && !isNewerVersion(installedVersionName(context), pendingVersion)) {
            // Android completed a previous install (or the pending APK is stale); remove
            // it instead of launching the installer again after the app restarts.
            deleteQuietly(file);
            prefs.edit().remove(KEY_PENDING_APK_PATH).remove(KEY_PENDING_APK_VERSION).apply();
            return false;
        }
        pendingApkInstall = file;
        return true;
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
                            // The APK was hashed while it was written, so verification
                            // never re-reads tens of megabytes from flash.
                            verification = UpdateVerifier.verify(
                                    activity, finalFile, expectedSha256, streamedSha);
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
     * Installs a verified APK that was downloaded in the background (or whose install was
     * deferred until the user grants "install unknown apps"). Called from
     * {@code MainActivity.onResume}: this is what makes the app update itself — the user
     * only confirms once in the system installer. The pending path is read from
     * preferences so a background download survives process death.
     */
    public static void checkPendingInstall(Activity activity) {
        if (activity == null || activity.isFinishing() || !hasPendingApk(activity)) {
            return;
        }
        File apk = pendingApkInstall;
        if (apk == null || !apk.exists()) {
            return;
        }
        SharedPreferences prefs = activity.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        boolean canInstall = Build.VERSION.SDK_INT < Build.VERSION_CODES.O
                || activity.getPackageManager().canRequestPackageInstalls();
        if (!canInstall) {
            // Reuse the existing system-settings path at most once per day. Do not relaunch
            // Settings on every onResume if the user declines; keep the verified APK pending.
            long now = System.currentTimeMillis();
            long promptedAt = prefs.getLong(KEY_LAST_INSTALL_PERMISSION_PROMPT, 0L);
            if (now - promptedAt >= INSTALL_PERMISSION_PROMPT_COOLDOWN_MS) {
                prefs.edit().putLong(KEY_LAST_INSTALL_PERMISSION_PROMPT, now).apply();
                installApk(activity, apk);
            }
            return;
        }
        pendingApkInstall = null;
        prefs.edit()
                .remove(KEY_PENDING_APK_PATH)
                .remove(KEY_PENDING_APK_VERSION)
                .remove(KEY_LAST_INSTALL_PERMISSION_PROMPT)
                .apply();
        installApk(activity, apk);
    }

    // ---------------------------------------------------------------------------------
    // Networking
    // ---------------------------------------------------------------------------------

    /**
     * Fetches a small text resource (GitHub API JSON, SHA256SUMS). For the GitHub API the
     * stored ETag is sent as {@code If-None-Match}: an unchanged release answers 304 with
     * no body, which keeps the daily check inside GitHub's unauthenticated quota and
     * makes "no new release" checks nearly free. Returns {@code null} on failure, an empty
     * string for a 304 (unchanged release), or the response body for a successful fetch.
     */
    private static String fetchText(String url, SharedPreferences prefs) {
        HttpURLConnection connection = null;
        try {
            connection = (HttpURLConnection) new URL(url).openConnection();
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(8000);
            connection.setReadTimeout(15000);
            connection.setRequestProperty("Accept", "application/vnd.github+json");
            connection.setRequestProperty("X-GitHub-Api-Version", "2022-11-28");
            connection.setRequestProperty("User-Agent", "ArenaAI-Mobile-Client");
            if (prefs != null && url.equals(GITHUB_LATEST_RELEASE_URL)) {
                String etag = prefs.getString(KEY_ETAG, null);
                if (etag != null && !etag.isEmpty()) {
                    connection.setRequestProperty("If-None-Match", etag);
                }
            }

            int code = connection.getResponseCode();
            if (code == HttpURLConnection.HTTP_NOT_MODIFIED) {
                // Unchanged since the last check: not a failure, just nothing new.
                return "";
            }
            if (code != HttpURLConnection.HTTP_OK) {
                return null;
            }
            if (prefs != null && url.equals(GITHUB_LATEST_RELEASE_URL)) {
                String etag = connection.getHeaderField("ETag");
                if (etag != null && !etag.isEmpty()) {
                    prefs.edit().putString(KEY_ETAG, etag).apply();
                }
            }
            // Cap the response body: the release JSON and SHA256SUMS are kilobytes. An
            // unbounded read would let a misbehaving endpoint grow the heap of a
            // background job, so stop at 256 KiB.
            StringBuilder builder = new StringBuilder(4096);
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(connection.getInputStream()), 8192)) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (builder.length() + line.length() > MAX_TEXT_RESPONSE_CHARS) {
                        break;
                    }
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
     * (GitHub release assets redirect to a signed S3 URL). Automatic following is
     * disabled so the manual loop below actually runs and 308 responses are handled too.
     */
    private static HttpURLConnection openConnectionWithRedirects(String initialUrl) throws Exception {
        String currentUrl = initialUrl;
        for (int i = 0; i < 8; i++) {
            if (currentUrl == null
                    || !currentUrl.toLowerCase(Locale.US).startsWith("https://")) {
                throw new IOException("Refusing non-HTTPS update redirect");
            }
            URL url = new URL(currentUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setInstanceFollowRedirects(false);
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

    /**
     * Picks the APK asset from a GitHub release. Returns
     * {@code [downloadUrl, fileName, size, assetDigest]} or {@code null} when the release
     * ships no HTTPS APK. Prefers an asset whose name mentions "arena" when several APKs
     * are present, and never accepts a plaintext URL.
     */
    static String[] findApkAsset(JSONObject release) {
        if (release == null) {
            return null;
        }
        String apkUrl = null;
        String apkName = null;
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
                String url = asset.optString("browser_download_url", "");
                if (url.isEmpty() || !url.toLowerCase(Locale.US).startsWith("https://")) {
                    // Never install from a plaintext URL, whatever the release says.
                    continue;
                }
                String lower = name.toLowerCase(Locale.US);
                if (!lower.endsWith(".apk")) {
                    continue;
                }
                boolean better = apkUrl == null
                        || (lower.contains("arena")
                        && apkName != null
                        && !apkName.toLowerCase(Locale.US).contains("arena"));
                if (better) {
                    apkUrl = url;
                    apkName = name;
                    apkSize = asset.optLong("size", 0L);
                    assetDigest = asset.optString("digest", null);
                }
            }
        }
        if (apkUrl == null) {
            return null;
        }
        return new String[]{apkUrl, apkName, String.valueOf(apkSize),
                assetDigest == null ? "" : assetDigest};
    }

    /**
     * Resolves the expected SHA-256 for an APK asset: the published {@code SHA256SUMS}
     * file first (with one retry on a transient failure), then GitHub's asset digest.
     * Returns {@code null} when no checksum is available, in which case the update is
     * refused by {@link UpdateVerifier}.
     */
    static String resolveExpectedSha256(JSONObject release, String apkName, String assetDigest) {
        String sumsUrl = null;
        JSONArray assets = release == null ? null : release.optJSONArray("assets");
        if (assets != null) {
            for (int i = 0; i < assets.length(); i++) {
                JSONObject asset = assets.optJSONObject(i);
                if (asset == null) {
                    continue;
                }
                String name = asset.optString("name", "").toLowerCase(Locale.US);
                String url = asset.optString("browser_download_url", "");
                if (!url.isEmpty() && url.toLowerCase(Locale.US).startsWith("https://")
                        && (name.equals("sha256sums") || name.equals("sha256sums.txt"))) {
                    sumsUrl = url;
                    break;
                }
            }
        }

        String expectedSha256 = null;
        if (sumsUrl != null) {
            expectedSha256 = findShaForFile(fetchText(sumsUrl, null), apkName);
            if (expectedSha256 == null) {
                // One retry: a transient failure here must not block a real update.
                expectedSha256 = findShaForFile(fetchText(sumsUrl, null), apkName);
            }
        }
        if (expectedSha256 == null && assetDigest != null && !assetDigest.isEmpty()) {
            String digest = assetDigest.trim();
            if (digest.toLowerCase(Locale.US).startsWith("sha256:")) {
                expectedSha256 = digest.substring("sha256:".length()).trim();
            }
        }
        return expectedSha256;
    }

    static String findShaForFile(String sumsText, String fileName) {
        if (sumsText == null || fileName == null) {
            return null;
        }
        String single = null;
        int checksumCount = 0;
        for (String line : sumsText.split("\\r?\\n")) {
            String trimmed = line.trim();
            if (trimmed.isEmpty()) {
                continue;
            }
            String[] parts = trimmed.split("\\s+", 2);
            if (parts.length != 2 || !parts[0].matches("[0-9a-fA-F]{64}")) {
                continue;
            }
            checksumCount++;
            String listedName = parts[1].replaceFirst("^\\*", "").trim();
            if (listedName.equals(fileName) || listedName.endsWith("/" + fileName)) {
                return parts[0].toLowerCase(Locale.US);
            }
            single = parts[0].toLowerCase(Locale.US);
        }
        // A release that ships exactly one APK and one checksum line stays updatable even
        // if the asset was renamed after the checksum file was generated.
        return checksumCount == 1 ? single : null;
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

    private static void runSafely(Runnable callback) {
        if (callback == null) {
            return;
        }
        try {
            callback.run();
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
        // Fall back to the build-time version so a PackageManager hiccup can never make
        // the updater compare against a stale hardcoded version.
        return BuildConfig.VERSION_NAME;
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
