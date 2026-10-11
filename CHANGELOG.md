# Changelog

All notable changes to the Arena.ai Android Client project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.1] - 2026-10-11

### Fixed & Hardened (Complete Audit Remediation & Mobile Production Release)

- **Android 11–15 Package Installation Resolution ("Invalid Package" Fix):**
  - Resolved installation failure where Android 11–15 devices rejected APKs targeting API 30+ that lacked binary APK Signing Blocks.
  - Enabled both **APK Signature Scheme v1** (JAR signing) and **APK Signature Scheme v2 & v3** via Gradle `signingConfigs.release` and official Android SDK `apksigner`.
  - Replaced ad-hoc jar signing with reproducible community release keystore valid through 2054.
  - Enforced strict 4-byte zip alignment (`zipalign`) on all 241 internal archive entries including `resources.arsc`.

- **5-Second Intelligent Auto-Reconnect Engine:**
  - Implemented automatic network error interception (`onReceivedError`), eliminating raw Chromium error screens (`net::ERR_INTERNET_DISCONNECTED`).
  - Added AMOLED `#000000` reconnect view with Classical Pillar logo, spinning loader, live countdown timer (`Checking in 5s...`), and manual "Retry Now" action.
  - Added background non-blocking connection polling thread pool (`networkExecutor`) probing `https://arena.ai` via `HttpURLConnection` HEAD requests every 5 seconds.
  - Automatic zero-touch recovery reloads `https://arena.ai` the exact moment connectivity is detected.

- **Authentic Adaptive Branding & Material You Support:**
  - Replaced default Android Studio robot vector with the authentic Classical Ionic Pillar vector mark in `@drawable/ic_launcher_foreground.xml`.
  - Applied pure `#000000` AMOLED black background to `@drawable/ic_launcher_background.xml`.
  - Added Android 13+ Material You themed monochrome vector (`@drawable/ic_launcher_monochrome.xml`).
  - Added dual adaptive XML definitions in `mipmap-anydpi-v26/` (`ic_launcher.xml` and `ic_launcher_round.xml`).
  - Pre-rendered 32-bit RGBA density icons across all standard buckets (`mdpi`, `hdpi`, `xhdpi`, `xxhdpi`, `xxxhdpi`) with circular and squircle launcher masks.
  - Configured icon attributes on both `<application>` and `<activity>` tags in `AndroidManifest.xml`.

- **Unified Single-Source Codebase:**
  - Completely retired the legacy decompiled smali tree (`arena_standalone_apk/`, 3,300+ files).
  - Established `android/` (`ai.arena.mobile`) as the single source of truth for all builds and tests.

- **Honest Branding & Legal Compliance:**
  - Dropped all "Official" claims; explicitly designated the project as an **Unofficial Community Client**.
  - Added clear disclaimers of non-affiliation with Arena, arena.ai, and LMSYS Org.
  - Added `LICENSE` (Apache-2.0) and `NOTICE` with third-party and trademark acknowledgments.

- **Client-Side Privacy Controls:**
  - Documented authentic direct HTTPS connection architecture to `https://arena.ai`.
  - Disabled HTML5 Geolocation API (`WebSettings.setGeolocationEnabled(false)`).
  - Restricted local file scheme access (`setAllowFileAccess(false)` and `setAllowContentAccess(false)`).
  - Sanitized User-Agent to clean Android Chrome standard (stripped `; wv` wrapper marker).
  - Enforced `android:usesCleartextTraffic="false"` and `android:allowBackup="false"`.
  - Kept only minimal required permission (`android.permission.INTERNET`).

- **Navigation Security Allow-List:**
  - Restricted embedded WebView navigation to Arena (`arena.ai`, `lmarena.ai`) and authorized identity providers (`accounts.google.com`, `github.com`, `appleid.apple.com`, `auth0.com`).
  - All outside URLs automatically hand off to the system web browser via `Intent.ACTION_VIEW`.

- **Modern Platform UX:**
  - Migrated from deprecated `onKeyDown`/`onBackPressed` to AndroidX `OnBackPressedCallback` for full Android 14+ / 16 (API 34–36) compatibility.
  - Upgraded `WebChromeClient.onShowFileChooser` to support multi-file uploads (`ClipData`), MIME type parsing, and safe cancellation for Vision battles.
  - Implemented `WebChromeClient.onCreateWindow` popup dialogs for OAuth workflows.
  - Added `SwipeRefreshLayout` with dark-mode styling for pull-to-refresh.
  - Ensured session cookie persistence via `CookieManager.getInstance().flush()` during activity lifecycle events.

- **Build Infrastructure & Automation:**
  - Added `android/gradle.properties` (`android.useAndroidX=true`), Gradle 8.2 wrapper, and ProGuard / R8 rules.
  - Added automated GitHub Actions CI workflow (`.github/workflows/build.yml`) for linting, testing, and release signing.
  - Configured Dependabot and consolidated dependencies.
  - Added 19 search-optimized GitHub repository topics.
  - Established 35/35 passing automated audit test suite.

---

## [1.0.0] - 2026-10-10

### Added
- Initial standalone APK release connecting to `https://arena.ai`.
- Direct pairwise model comparisons, leaderboard views, and persistent cookie sessions.
