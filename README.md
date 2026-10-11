<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="official_apple_touch_icon_dark.png">
    <source media="(prefers-color-scheme: light)" srcset="official_apple_touch_icon.png">
    <img alt="Arena.ai Official Logo" src="official_apple_touch_icon_dark.png" width="128" height="128">
  </picture>
</p>

<h1 align="center">Arena.ai Android Client (Unofficial)</h1>

<p align="center">
  <strong>An open-source, mobile-optimized Android client for <a href="https://arena.ai">Arena (arena.ai)</a></strong>
</p>

<p align="center">
  <a href="https://github.com/Mr-Nobody-Anonymous/arena-ai-android/actions/workflows/build.yml"><img src="https://github.com/Mr-Nobody-Anonymous/arena-ai-android/actions/workflows/build.yml/badge.svg" alt="Android Build & CI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache_2.0-blue.svg" alt="License"></a>
  <a href="https://developer.android.com"><img src="https://img.shields.io/badge/Platform-Android_8.0+_(API_26+)-brightgreen.svg" alt="Platform"></a>
  <a href="android/"><img src="https://img.shields.io/badge/Package-ai.arena.mobile-purple.svg" alt="Package"></a>
</p>

An open-source, mobile-optimized Android client for **[Arena (arena.ai)](https://arena.ai)** (formerly LMSYS Chatbot Arena). This application provides a full-screen, native Android interface for pairwise LLM benchmarking, real-time blind voting, model leaderboards, and image battles.

> [!IMPORTANT]
> **Disclaimer:** This is an independent, community-driven open-source project. It is **not affiliated with, maintained by, endorsed by, or sponsored by Arena, arena.ai, or LMSYS Org**. "Arena", "Chatbot Arena", and the Classical Ionic Pillar mark are the intellectual property and trademarks of Arena / arena.ai.

---

## Features

- **📱 Standalone Native Android Client:** Connects directly over encrypted HTTPS to `https://arena.ai` without requiring any intermediate desktop servers, proxies, or local network setups.
- **🏛️ Authentic Branding:** Incorporates the authentic Classical Ionic Pillar mark in Android adaptive icon formats (`@drawable/ic_launcher_foreground.xml` on pure `#000000` AMOLED black background), including Android 13+ themed monochrome icons.
- **🔄 Session & Login Persistence:** Preserves authentication cookies across app launches by flushing session state to disk during activity lifecycle events (`onPageFinished`, `onPause`, `onDestroy`).
- **🛡️ Strict Client-Side Privacy:**
  - **No Telemetry or Tracking:** Zero analytics SDKs, trackers, or third-party monitoring libraries.
  - **HTML5 Geolocation Disabled:** `WebSettings.setGeolocationEnabled(false)` prevents scripts from requesting GPS/location data.
  - **Local File Scheme Restrictions:** `setAllowFileAccess(false)` and `setAllowContentAccess(false)` block access to private local file paths.
  - **Navigation Security Allow-List:** Embedded WebView navigation is strictly confined to Arena (`arena.ai`, `lmarena.ai`) and trusted authentication identity providers. All outside URLs automatically open in your device's external web browser.
- **📁 File Upload Bridge:** Full HTML5 file chooser integration supporting multi-file uploads (`ClipData`) for vision battle images and file inputs.
- **⬅️ Predictive & Modern Back Navigation:** Built with AndroidX `OnBackPressedCallback`, providing smooth in-app back navigation compatible with Android 14+ and Android 15/16 (API 34–36).
- **🔄 Pull-to-Refresh & 5-Second Network Auto-Reconnect:** Automatically detects offline or interrupted connectivity, displays an AMOLED black reconnecting screen with live countdown and "Retry Now" action, and continuously checks connectivity every 5 seconds in background to restore Arena.ai instantly once Wi-Fi or cellular network is enabled.
- **🔒 Hardened Security Profile:** Enforces `android:usesCleartextTraffic="false"` (HTTPS only), `android:allowBackup="false"` (prevents adb credential extraction), and requests only the minimal `INTERNET` permission.

---

## Download & Installation

### Option 1: Direct APK Download
1. Download the verified release APK from the **[Releases](https://github.com/Mr-Nobody-Anonymous/arena-ai-android/releases)** page:
   - **File:** `ArenaAI.apk`
   - **Package:** `ai.arena.mobile`
   - **Minimum Android:** Android 8.0 Oreo (API 26)
   - **Target Android:** Android 14 (API 34)
2. Open the downloaded APK on your Android device and install it (allow "Install unknown apps" if prompted).

### Option 2: Build from Source
Ensure you have **JDK 17** (or newer) and the **Android SDK (API 34)** installed:
```bash
# Clone the repository
git clone https://github.com/Mr-Nobody-Anonymous/arena-ai-android.git
cd arena-ai-android/android

# Run unit tests
./gradlew test

# Build debug APK
./gradlew assembleDebug

# Build release APK
./gradlew assembleRelease
```
The compiled APK will be located in `android/app/build/outputs/apk/`.

---

## Release Verification & Checksums

Always verify the cryptographic integrity of downloaded APK releases before installation:

| Attribute | Value |
| :--- | :--- |
| **File Name** | `ArenaAI.apk` |
| **File Size** | `2,005,618 bytes` |
| **SHA-256 Checksum** | `d63bc69f536ea46343cab1de0a41d17e488fb3b30940aa0832c0597404d96f1d` |
| **Package Name** | `ai.arena.mobile` |
| **Version** | `1.0.1 (versionCode 2)` |
| **Zip Alignment** | Verified 4-byte aligned (all 296 stored entries, `resources.arsc`) |
| **Signature Scheme** | JAR signature (v1) with SHA-256 digest |

### Signing Certificate Fingerprints
```text
Owner / Issuer: CN=Arena Mobile Community, OU=Open Source, O=Community, L=San Francisco, ST=CA, C=US
Algorithm:      2048-bit RSA with SHA384withRSA
Validity:       October 11, 2026 to February 26, 2054
SHA-256:        7B:7C:33:2A:78:9C:48:F2:97:95:46:08:11:F6:B7:31:B6:F2:B0:62:29:9C:AD:71:A5:CB:E4:59:EC:E8:2F:49
SHA-1:          A1:B9:F5:28:82:4A:63:0F:AA:2B:77:B5:F7:AF:2A:BB:BF:D7:01:1D
```

To verify on Linux/macOS:
```bash
sha256sum ArenaAI.apk
```
To verify on Windows PowerShell:
```powershell
Get-FileHash -Algorithm SHA256 ArenaAI.apk
```

---

## Architecture & Project Structure

```text
arena-ai-android/
├── .github/
│   ├── workflows/build.yml     # Automated CI pipeline (Gradle build, test, lint)
│   ├── dependabot.yml          # Automated dependency security tracking
│   └── ISSUE_TEMPLATE/         # Bug report & feature request templates
├── android/                    # Single source of truth Android application
│   ├── app/
│   │   ├── build.gradle        # App Gradle configuration (ai.arena.mobile, SDK 34)
│   │   ├── proguard-rules.pro  # R8 / ProGuard optimization rules
│   │   └── src/
│   │       ├── main/
│   │       │   ├── AndroidManifest.xml
│   │       │   ├── java/ai/arena/mobile/MainActivity.java
│   │       │   └── res/        # Adaptive drawables & density PNG icons
│   │       └── test/           # Unit tests (NavigationPolicyTest.java)
│   ├── gradle/wrapper/         # Gradle 8.2 wrapper binaries and configuration
│   ├── gradle.properties       # AndroidX configuration
│   └── gradlew, gradlew.bat    # Cross-platform Gradle wrapper execution scripts
├── tests/                      # Automated test suite (35/35 passing)
├── server.js                   # Optional local reverse proxy (development inspection only)
├── ANALYSIS_REPORT.md          # Complete audit remediation & verification report
├── CHANGELOG.md                # Detailed release and fix changelog
├── CONTRIBUTING.md             # Contribution guidelines
├── CODE_OF_CONDUCT.md          # Contributor covenant
├── LICENSE                     # Apache License 2.0
├── NOTICE                      # Legal & trademark notices
├── PRIVACY.md                  # Comprehensive privacy statement
└── SECURITY.md                 # Vulnerability disclosure policy
```

---

## Authentication Notes & Limitations

- **Email & Password Login:** Fully supported and preserved across sessions via `CookieManager`.
- **Secondary Popups:** Popups for authentication providers are managed inside dedicated WebView dialogs via `WebChromeClient.onCreateWindow`.
- **Google Sign-In Policy:** Google enforces strict policies restricting OAuth from embedded WebViews (`disallowed_useragent`). The app removes webview identifier markers from the User-Agent to improve compatibility, but users requiring Google OAuth may need to authenticate via email/password or use external browser login.
- **Optional Development Proxy:** `server.js` is provided purely as an optional desktop utility for testing web traffic and headers; the Android app connects directly to `https://arena.ai` and does not require this proxy.

---

## License

This project is licensed under the **Apache License, Version 2.0**. See the [LICENSE](LICENSE) file for details. Third-party components and trademark attributions are documented in [NOTICE](NOTICE).
