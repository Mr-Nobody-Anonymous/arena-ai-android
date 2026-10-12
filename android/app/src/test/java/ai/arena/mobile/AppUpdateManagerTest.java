package ai.arena.mobile;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Unit tests validating version comparison logic for the in-app self-updater.
 */
public class AppUpdateManagerTest {

    @Test
    public void testRemoteVersionHigherTriggersUpdate() {
        assertTrue(AppUpdateManager.isNewerVersion("1.0.1", "v1.0.2"));
        assertTrue(AppUpdateManager.isNewerVersion("1.0.1", "1.0.2"));
        assertTrue(AppUpdateManager.isNewerVersion("1.0.1", "v1.1.0"));
        assertTrue(AppUpdateManager.isNewerVersion("1.0.1", "v2.0.0"));
        assertTrue(AppUpdateManager.isNewerVersion("1.0.1", "1.0.1.1"));
    }

    @Test
    public void testSameOrLowerVersionDoesNotTriggerUpdate() {
        assertFalse(AppUpdateManager.isNewerVersion("1.0.2", "v1.0.2"));
        assertFalse(AppUpdateManager.isNewerVersion("1.0.2", "1.0.2"));
        assertFalse(AppUpdateManager.isNewerVersion("1.0.2", "v1.0.1"));
        assertFalse(AppUpdateManager.isNewerVersion("2.0.0", "v1.9.9"));
    }

    @Test
    public void testNullOrEmptyVersionHandledSafely() {
        assertFalse(AppUpdateManager.isNewerVersion(null, "v1.0.2"));
        assertFalse(AppUpdateManager.isNewerVersion("1.0.1", null));
        assertFalse(AppUpdateManager.isNewerVersion("", "v1.0.2"));
        assertFalse(AppUpdateManager.isNewerVersion("1.0.1", ""));
        assertFalse(AppUpdateManager.isNewerVersion(null, null));
    }

    @Test
    public void testPrefixVStripping() {
        assertTrue(AppUpdateManager.isNewerVersion("v1.0.1", "v1.0.2"));
        assertTrue(AppUpdateManager.isNewerVersion("v1.0.1", "1.0.2"));
        assertFalse(AppUpdateManager.isNewerVersion("v1.0.2", "v1.0.2"));
    }
}
