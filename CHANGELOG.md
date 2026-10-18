# Changelog

All notable changes to the Arena.ai Android Client project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

## [1.0.4] - 2026-10-18

### Changed — Refresh gesture and update discovery

- **Pull-to-refresh is back, without the old reload bug:** the gesture is armed only when the
  page reports that the document *and* every visible nested scroller are at the top
  (`VIEWPORT_SHIM_JS` → origin-locked bridge → `canPullToRefresh()`). Scrolling up through a
  battle no longer reloads the page; pulling down at the top reloads the current URL, and on the
  reconnect screen the same gesture retries immediately. WebViews without the WebMessage bridge
  keep the gesture disabled rather than risk an accidental reload.
- **Updater discovers releases promptly:** checks now run on launch, on resume and after a page
  load with a 15-minute throttle (5-minute retry after a failure), a 12-hour re-prompt cooldown per
  version, HTTPS-only asset URLs, and a checksum lookup that still resolves when the APK asset was
  renamed.

### Added — Native Web Capability Bridge (no new app UI)

- **Real download pipeline (`DownloadHandler`):** HTTPS downloads are queued with Android's
  `DownloadManager`, carrying the WebView's Arena session cookies and user agent, with progress in
  the notification shade. `blob:` exports are resolved inside the page and written to Downloads
  through `MediaStore`; `data:` URLs are decoded and saved. Replaces the previous bare
  `ACTION_VIEW` hand-off that could not download authenticated or blob files.
- **Camera capture:** `<input type="file" accept="image/*" capture>` now offers the system camera
  alongside the file picker, with output written through `FileProvider` (new `captures` path).
- **Native JavaScript dialogs:** `alert()`, `confirm()`, `prompt()` and `beforeunload` are handled
  with native dialogs. A stock `WebChromeClient` silently drops these, which broke confirmation and
  "unsaved changes" flows on the site.
- **Fullscreen HTML5 video:** `onShowCustomView` / `onHideCustomView`, with back-button exit.
- **Share sheet bridge:** `navigator.share()` / `navigator.canShare()` are shimmed for Arena origins
  and forwarded to the Android share sheet through an origin-locked `addWebMessageListener` bridge.
- **`intent://` and external schemes:** deep links are parsed with `Intent.parseUri`, honour
  `browser_fallback_url`, and open in the matching system app. `mailto:`, `tel:`, `sms:` and
  `market:` links now work.
- **OAuth popup lifecycle:** secondary windows are tracked, origin-checked, destroyed on dismiss,
  rotation or activity teardown, and no longer leak `Dialog`/`WebView` instances. Ordinary
  `window.open` links return to the main view instead of opening a second full-screen layer.
- **Resilience:** WebView renderer crashes are recovered by recreating the view at the last URL;
  main-frame HTTP 5xx, TLS failures and offline errors render the reconnect screen. Retry now uses
  exponential backoff (5 s → 30 s) and cannot touch a shut-down executor.
- **Accessibility:** WebView text zoom follows the system font scale.

### Security

- **Verified updates (`UpdateVerifier`):** before the installer opens, the APK must match the
  published SHA-256, carry the `ai.arena.mobile` package name, not downgrade the version code, and
  be signed by the same certificate as the installed app. Failed, cancelled or interrupted
  downloads are deleted.
- **Stable release signing:** removed the hard-coded `arena1234` keystore password and the
  `keytool -genkey` step that generated a new key on every CI run. Signing now reads
  `ARENA_RELEASE_*` variables from GitHub Actions secrets; release builds warn loudly and fall back
  to the debug key when unset. `enableV3Signing true` added (v1 + v2 + v3).
- **Correct documentation:** certificate fingerprints, algorithm and validity now match the actual
  v1.0.3 APK; `REQUEST_INSTALL_PACKAGES`, GitHub update checks, third-party cookies and OAuth
  recipients are disclosed in `PRIVACY.md` / `SECURITY.md`.
- **Backup hardening:** Android 12+ `data-extraction-rules.xml` excludes all domains from cloud
  backup and device transfer; `android:enableOnBackInvokedCallback="true"` opts into predictive back.
- **Licensing:** `LICENSE` and `NOTICE` are now bundled inside the APK under `assets/`.

### Changed

- **Updater:** checks are throttled to once per 24 hours (and once per process) instead of firing on
  every page load; drafts and pre-releases are ignored; "Skip This Version" is persisted; release
  notes are shown; downloads show percentage progress, support cancel, check free space and use an
  atomic `.part` → `.apk` rename.
- **CI:** `build.yml` now restores the release keystore from secrets, validates the Gradle wrapper,
  runs lint and `npm audit` (report-only), verifies the APK with `scripts/verify-apk.sh`, caches
  Gradle/npm and declares least-privilege permissions and timeouts. New tag-triggered `release.yml`
  signs, verifies and publishes the APK and `SHA256SUMS` to GitHub Releases.
- **Tooling:** `gradlew` and `scripts/verify-apk.sh` are committed executable; `package.json` is
  `private`; `package-lock.json` name/version corrected; `tests/test-results.json` untracked.
- **Icon script:** now writes to `android/app/src/main/res` (the old path was deleted), adds round
  icons, and `requirements.txt` pins Pillow.
- **Dev server:** `/api/network-info` reports a real LAN address for its QR code instead of
  `127.0.0.1`/`0.0.0.0`, adds `/api/version`, and documents `HOST=0.0.0.0`.

### Tests

- Audit suite expanded from 36 to 81 checks: native capability bridge, update integrity, release
  engineering, the shipped APK artifact (SHA-256, zip alignment, v2 signature block), page-aware
  pull-to-refresh gating, updater discovery/throttling, policy disclosures and development-server
  endpoints.

---

## [1.0.3] - 2026-10-12

### Added & Enhanced

- **Expanded Ecosystem Authentication & Navigation Allow-List:**
  - Added Hugging Face (`huggingface.co`), LMSYS Org (`lmsys.org`, `chat.lmsys.org`), Microsoft (`login.microsoftonline.com`, `live.com`), and Discord (`discord.com`) to in-app allow-list in `MainActivity.java`.
  - Enables smooth SSO login flows and leaderboard navigation without kicking users to external browsers.
- **Automated CI Architecture & Security Test Execution:**
  - Integrated 36-point automated audit compliance suite directly into GitHub Actions CI (`.github/workflows/build.yml`).
- **Dependabot Governance:**
  - Added update groups (`github-actions`, `gradle-dependencies`, `npm-dependencies`) and ignore rules in `.github/dependabot.yml`.
- **Live Upgrade Target:**
  - Published v1.0.3 to GitHub Releases, serving as a live verification update for the in-app self-updater.

---

## [1.0.2] - 2026-10-12

### Fixed & Enhanced

- **Smooth In-App Scrolling & Gestures (Scroll-Up Reload Bug Fixed):**
  - Resolved the critical issue where scrolling up in chat history, battle responses, or leaderboards triggered an unexpected page reload and destroyed conversation state.
  - Disabled `SwipeRefreshLayout`'s touch drag interception (`swipeRefreshLayout.setEnabled(false)` and `swipeRefreshLayout.setOnChildScrollUpCallback((parent, child) -> true)`).
  - All vertical touch gestures now flow seamlessly and uninterrupted to the underlying WebView and internal DOM containers.

- **In-App Automated Self-Updater from GitHub Releases:**
  - Added background update checker (`AppUpdateManager`) that automatically checks `https://api.github.com/repos/Mr-Nobody-Anonymous/arena-ai-android/releases/latest`.
  - Added semantic version comparison logic to determine if a newer version is published.
  - Prompts the user with a clean, native `AlertDialog` asking if they would like to download and install the update.
  - Downloads the APK directly to app cache and initiates the system package installer via `androidx.core.content.FileProvider`.
  - Configured `<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />` and `res/xml/file_paths.xml`.
  - Zero persistent UI clutter added to the core application interface.

- **Enhanced Multi-File & Image Upload Bridge:**
  - Refactored `onShowFileChooser` to support complex comma-separated MIME types, extension mapping (e.g. `.png`, `.jpg`), and image wildcards (`image/*`).
  - Added support for `ClipData` multi-selection, allowing multiple benchmark images to be uploaded simultaneously for Vision battles.
  - Guaranteed safe cancellation callbacks so the WebView file picker never hangs.

- **Automated Testing & CI Integration:**
  - Added `AppUpdateManagerTest.java` unit test suite covering semantic version comparisons, tag prefixes, and edge cases.
  - Refactored `NavigationPolicyTest.java` to test production `MainActivity.isHostAllowed(...)` directly.
  - Added Node.js test runner step (`npm test`) directly into GitHub Actions CI workflow (`.github/workflows/build.yml`).
  - Expanded automated audit test suite to 36 out of 36 passing checks (100% pass rate).

- **Ecosystem Navigation & OAuth Enhancements:**
  - Expanded `ALLOWED_HOST_SUFFIXES` in `MainActivity.java` with `huggingface.co`, `lmsys.org`, `login.microsoftonline.com`, `live.com`, and `discord.com` to prevent OAuth session fragmentation.
  - Hardened `DownloadListener` against null or empty download URIs.

- **Dependabot Governance & Branch Hygiene:**
  - Configured update grouping in `.github/dependabot.yml` (`github-actions`, `gradle-dependencies`, `npm-dependencies`).
  - Added ignore rules for incompatible major bumps (`AGP > 8.x`, `gradle-wrapper > 8.x`, `swiperefreshlayout >= 1.2.0`, and merged `kotlin-stdlib-jdk7/8`).
  - Resolved and merged dependency pull requests #11 and #13, declined incompatible PR #12, and pruned remote tracking branches.

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
