package ai.arena.mobile;

import android.content.Context;

import androidx.work.BackoffPolicy;
import androidx.work.Constraints;
import androidx.work.ExistingPeriodicWorkPolicy;
import androidx.work.NetworkType;
import androidx.work.PeriodicWorkRequest;
import androidx.work.WorkManager;

import java.util.concurrent.TimeUnit;

/** Schedules the daily network-constrained GitHub Releases check. */
final class UpdateScheduler {

    static final long INTERVAL_MS = 24L * 60L * 60L * 1000L;
    static final String UNIQUE_WORK_NAME = "arena_daily_update_check";

    private UpdateScheduler() {
    }

    /**
     * Enqueues a periodic check that survives process death and device reboot. WorkManager
     * applies Android's battery/Doze rules and only runs the job with network connectivity;
     * Android may defer it slightly to save battery. Unique work prevents duplicate jobs.
     */
    static void scheduleDailyCheck(Context context) {
        if (context == null) {
            return;
        }
        Constraints constraints = new Constraints.Builder()
                .setRequiredNetworkType(NetworkType.CONNECTED)
                .build();
        PeriodicWorkRequest request = new PeriodicWorkRequest.Builder(
                UpdateWorker.class, 24, TimeUnit.HOURS)
                .setConstraints(constraints)
                // Do not let a stale retry pile up more than a day of backoff; the next
                // periodic run comes soon enough.
                .setBackoffCriteria(BackoffPolicy.EXPONENTIAL, 30, TimeUnit.MINUTES)
                .build();
        WorkManager.getInstance(context.getApplicationContext())
                .enqueueUniquePeriodicWork(
                        UNIQUE_WORK_NAME,
                        ExistingPeriodicWorkPolicy.KEEP,
                        request);
    }

    static void cancelDailyCheck(Context context) {
        if (context != null) {
            WorkManager.getInstance(context.getApplicationContext())
                    .cancelUniqueWork(UNIQUE_WORK_NAME);
        }
    }
}
