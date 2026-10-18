package ai.arena.mobile;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Unit tests validating host allow-list and navigation security rules
 */
public class NavigationPolicyTest {

    @Test
    public void testOfficialArenaDomainsAllowed() {
        assertTrue(MainActivity.isHostAllowed("arena.ai"));
        assertTrue(MainActivity.isHostAllowed("www.arena.ai"));
        assertTrue(MainActivity.isHostAllowed("chat.arena.ai"));
        assertTrue(MainActivity.isHostAllowed("lmarena.ai"));
        assertTrue(MainActivity.isHostAllowed("lmsys.org"));
        assertTrue(MainActivity.isHostAllowed("chat.lmsys.org"));
    }

    @Test
    public void testOAuthDomainsAllowed() {
        assertTrue(MainActivity.isHostAllowed("accounts.google.com"));
        assertTrue(MainActivity.isHostAllowed("github.com"));
        assertTrue(MainActivity.isHostAllowed("appleid.apple.com"));
        assertTrue(MainActivity.isHostAllowed("huggingface.co"));
        assertTrue(MainActivity.isHostAllowed("login.microsoftonline.com"));
        assertTrue(MainActivity.isHostAllowed("discord.com"));
        assertTrue(MainActivity.isHostAllowed("auth0.com"));
        assertTrue(MainActivity.isHostAllowed("login.live.com"));
    }

    @Test
    public void testExternalUntrustedDomainsBlocked() {
        assertFalse(MainActivity.isHostAllowed("example.com"));
        assertFalse(MainActivity.isHostAllowed("malicious-site.org"));
        assertFalse(MainActivity.isHostAllowed("arena.ai.evil.com"));
        assertFalse(MainActivity.isHostAllowed("fake-arena.ai.phishing.net"));
        // Narrowed allow-list: only the OAuth hosts, not the whole consumer product.
        assertFalse(MainActivity.isHostAllowed("google.com"));
        assertFalse(MainActivity.isHostAllowed("mail.google.com"));
        assertFalse(MainActivity.isHostAllowed("live.com"));
    }

    @Test
    public void testNullOrEmptyBlocked() {
        assertFalse(MainActivity.isHostAllowed(null));
        assertFalse(MainActivity.isHostAllowed(""));
    }
}
