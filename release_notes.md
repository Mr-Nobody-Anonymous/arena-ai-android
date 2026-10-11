# 🏛️ Arena.ai Android Client v1.0.1 (Community Release)

This release addresses all findings identified during the comprehensive technical audit, establishing the clean Android Gradle project (`ai.arena.mobile`) as the single source of truth, correcting branding and privacy claims, fixing launcher icon rendering, and providing an independently verifiable, 4-byte aligned, signed release APK.

> **Disclaimer:** This is an independent, community-driven open-source project and is **not affiliated with, maintained by, endorsed by, or sponsored by Arena or LMSYS Org**.

---

## 📲 Verified Release Downloads

| File | Size | SHA-256 Checksum |
| :--- | :--- | :--- |
| **[ArenaAI.apk](ArenaAI.apk)** | 1,992,506 bytes | `668191ce70f6ec43353ab1144ba346a6db7eb4d5fa1b18617d94fc2db1b56d3c` |
| **[SHA256SUMS](SHA256SUMS)** | 82 bytes | Integrity checksum manifest |

---

## 🔍 Cryptographic Signing & Verification

The release APK is signed with the community release key:

- **Signer:** `CN=Arena Mobile Community, OU=Open Source, O=Community, L=San Francisco, ST=CA, C=US`
- **Certificate Validity:** October 11, 2026 → February 26, 2054
- **SHA-256 Certificate Fingerprint:**  
  `7B:7C:33:2A:78:9C:48:F2:97:95:46:08:11:F6:B7:31:B6:F2:B0:62:29:9C:AD:71:A5:CB:E4:59:EC:E8:2F:49`
- **SHA-1 Certificate Fingerprint:**  
  `A1:B9:F5:28:82:4A:63:0F:AA:2B:77:B5:F7:AF:2A:BB:BF:D7:01:1D`
- **Zip Alignment:** 100% verified 4-byte alignment across all 296 stored entries (including `resources.arsc`).

Verify in terminal:
```bash
sha256sum -c SHA256SUMS
```

---

## 🌟 What's New & Fixed in v1.0.1

### 🏛️ Authentic Adaptive Branding
- Replaced Android Studio template robot vector with the official **Classical Ionic Pillar** mark in `@drawable/ic_launcher_foreground.xml` and monochrome layer (`@drawable/ic_launcher_monochrome.xml`).
- Applied solid `#000000` AMOLED black background to `@drawable/ic_launcher_background.xml`.
- Generated matching density icons for `mdpi`, `hdpi`, `xhdpi`, `xxhdpi`, and `xxxhdpi`.

### 🛡️ Navigation Security & Client-Side Privacy
- **Navigation Allow-List:** Embedded WebView is restricted to `arena.ai`, `lmarena.ai`, and authentication identity providers. Any external URL is safely handed off to the system web browser via `Intent.ACTION_VIEW`.
- **Accurate Privacy Architecture:** Removed misleading "Zero IP leakage" claims. Documented authentic direct HTTPS connection to `https://arena.ai` with client-side controls:
  - `setGeolocationEnabled(false)` (disables HTML5 GPS requests)
  - `setAllowFileAccess(false)` and `setAllowContentAccess(false)` (blocks `file://` scheme)
  - Standard clean Android Chrome User-Agent.

### 📱 Android Platform & UX Enhancements
- **Predictive Back Navigation:** Migrated to AndroidX `OnBackPressedCallback`, preventing navigation breakage on Android 14+ / 16 (API 34–36).
- **Multi-File Chooser:** Upgraded `WebChromeClient.onShowFileChooser` to support `ClipData` multi-select for Vision battle uploads.
- **Session Persistence:** Explicit `CookieManager.flush()` calls on page finish, pause, and destroy lifecycle events.
- **Pull-to-Refresh:** Added `SwipeRefreshLayout` with dark-mode styling.
- **Secondary Window Popups:** Handled window creation for OAuth workflows via `onCreateWindow`.

### 🏗️ Build Infrastructure & Repository Hygiene
- **Unified Single Codebase:** Retired the 3,300+ legacy smali files. Package unified under `ai.arena.mobile`.
- **Gradle & CI:** Added Gradle 8.2 wrapper, `gradle.properties` (`android.useAndroidX=true`), ProGuard rules, Android unit tests, and GitHub Actions CI workflow (`.github/workflows/build.yml`).
- **Legal & Governance:** Added `LICENSE` (Apache-2.0), `NOTICE`, `PRIVACY.md`, `SECURITY.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `.github/dependabot.yml`, and issue/PR templates.
