# Changelog

All notable changes to the Arena.ai Android Client project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.1] - 2026-10-10

### Fixed & Hardened (Complete Audit Remediation)
- **Unified Codebase:** Retired the legacy decompiled smali tree (`arena_standalone_apk/`, 3,300+ files) and made `android/` the single source of truth under package `ai.arena.mobile`.
- **Adaptive Icon Fix:** Replaced default Android Studio robot vector with the authentic Classical Ionic Pillar vector mark in `@drawable/ic_launcher_foreground.xml`, pure black `#000000` background, and themed monochrome layer (`@drawable/ic_launcher_monochrome.xml`).
- **Honest Branding & Attribution:** Dropped all "Official" claims; explicitly designated the project as an **Unofficial Community Client**; added clear disclaimer of non-affiliation with Arena (formerly LMSYS).
- **Accurate Privacy Documentation:** Removed inaccurate "Zero IP leakage" claims; fully documented client-side privacy controls (geolocation disabled, file scheme blocked, clean User-Agent, direct HTTPS connection).
- **Navigation Security Allow-List:** Restricted embedded WebView navigation to Arena (`arena.ai`, `lmarena.ai`) and authorized OAuth identity providers. All outside domains open securely in the system web browser.
- **Modern Back Navigation:** Migrated from deprecated `onKeyDown`/`onBackPressed` to AndroidX `OnBackPressedCallback` for full Android 14+ (API 34/35/36) compatibility.
- **Enhanced File Chooser:** Upgraded `WebChromeClient.onShowFileChooser` to support multi-file uploads (`ClipData`), MIME type filtering, and safe cancellation.
- **Secondary Window & OAuth Popups:** Implemented `WebChromeClient.onCreateWindow` with dedicated popup dialogs and third-party cookie support.
- **Pull-to-Refresh & Downloads:** Integrated `SwipeRefreshLayout` with dark theme styling and `DownloadListener` handoff.
- **Build & CI Automation:** Added `android/gradle.properties`, full Gradle wrapper (8.2), ProGuard rules, Android unit tests, and GitHub Actions CI workflow.
- **Legal & Community Hygiene:** Added `LICENSE` (Apache-2.0), `NOTICE`, `PRIVACY.md`, `SECURITY.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, issue/PR templates, and `.github/dependabot.yml`.

---

## [1.0.0] - 2026-10-10

### Added
- Initial standalone APK release connecting to `https://arena.ai`.
- Direct pairwise model comparisons, leaderboard views, and persistent cookie sessions.
