package ai.arena.mobile;

import org.junit.Test;
import static org.junit.Assert.*;

import java.util.Arrays;
import java.util.List;

/**
 * Unit tests validating host allow-list and navigation security rules
 */
public class NavigationPolicyTest {

    private static final List<String> ALLOWED_HOST_SUFFIXES = Arrays.asList(
            "arena.ai",
            "lmarena.ai",
            "accounts.google.com",
            "google.com",
            "github.com",
            "appleid.apple.com",
            "auth0.com"
    );

    private boolean isHostAllowed(String host) {
        if (host == null) return false;
        String lowerHost = host.toLowerCase();
        for (String allowed : ALLOWED_HOST_SUFFIXES) {
            if (lowerHost.equals(allowed) || lowerHost.endsWith("." + allowed)) {
                return true;
            }
        }
        return false;
    }

    @Test
    public void testOfficialArenaDomainsAllowed() {
        assertTrue(isHostAllowed("arena.ai"));
        assertTrue(isHostAllowed("www.arena.ai"));
        assertTrue(isHostAllowed("chat.arena.ai"));
        assertTrue(isHostAllowed("lmarena.ai"));
    }

    @Test
    public void testOAuthDomainsAllowed() {
        assertTrue(isHostAllowed("accounts.google.com"));
        assertTrue(isHostAllowed("github.com"));
        assertTrue(isHostAllowed("appleid.apple.com"));
    }

    @Test
    public void testExternalUntrustedDomainsBlocked() {
        assertFalse(isHostAllowed("example.com"));
        assertFalse(isHostAllowed("malicious-site.org"));
        assertFalse(isHostAllowed("arena.ai.evil.com"));
        assertFalse(isHostAllowed("fake-arena.ai.phishing.net"));
    }

    @Test
    public void testNullOrEmptyBlocked() {
        assertFalse(isHostAllowed(null));
        assertFalse(isHostAllowed(""));
    }
}
