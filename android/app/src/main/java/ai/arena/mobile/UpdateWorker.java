package ai.arena.mobile;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.work.Worker;
import androidx.work.WorkerParameters;

/** Runs the daily GitHub Releases check away from the UI thread. */
public class UpdateWorker extends Worker {
    public UpdateWorker(@NonNull Context context, @NonNull WorkerParameters params) {
        super(context, params);
    }

    @NonNull
    @Override
    public Result doWork() {
        // Runs on WorkManager's own worker thread. The check never blocks on a latch and
        // never buffers the APK in memory: it streams the download to the cache directory.
        boolean completed = AppUpdateManager.checkForUpdatesInBackground(getApplicationContext());
        return completed ? Result.success() : Result.retry();
    }
}
