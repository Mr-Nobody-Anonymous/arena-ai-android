<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="official_apple_touch_icon_dark.png">
    <source media="(prefers-color-scheme: light)" srcset="official_apple_touch_icon.png">
    <img alt="Arena.ai Official Logo" src="official_apple_touch_icon_dark.png" width="128" height="128">
  </picture>
</p>

<h1 align="center">Arena.ai Android Client (Unofficial)</h1>

<p align="center">
  <strong>An open-source, mobile-optimized native Android client for <a href="https://arena.ai">Arena (arena.ai)</a></strong>
</p>

<p align="center">
  <a href="https://github.com/Mr-Nobody-Anonymous/arena-ai-android/actions/workflows/build.yml"><img src="https://github.com/Mr-Nobody-Anonymous/arena-ai-android/actions/workflows/build.yml/badge.svg" alt="Android Build & CI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache_2.0-blue.svg" alt="License"></a>
  <a href="https://developer.android.com"><img src="https://img.shields.io/badge/Platform-Android_8.0+_(API_26+)-brightgreen.svg" alt="Platform"></a>
  <a href="android/"><img src="https://img.shields.io/badge/Package-ai.arena.mobile-purple.svg" alt="Package"></a>
  <a href="https://github.com/Mr-Nobody-Anonymous/arena-ai-android/releases/tag/v1.0.1"><img src="https://img.shields.io/badge/Release-v1.0.1_(Verified)-orange.svg" alt="Release"></a>
  <a href="tests/"><img src="https://img.shields.io/badge/Audit_Tests-35%2F35_Passing-success.svg" alt="Audit Tests"></a>
</p>

An open-source, high-performance native Android application for **[Arena (arena.ai)](https://arena.ai)** (formerly LMSYS Chatbot Arena). This application provides a full-screen, mobile-optimized experience for crowdsourced LLM evaluation, blind pairwise model battles, multimodal vision benchmarks, live Elo leaderboards, and direct model chat.

> [!IMPORTANT]
> **Disclaimer:** This is an independent, community-driven open-source project. It is **not affiliated with, maintained by, endorsed by, or sponsored by Arena, arena.ai, or LMSYS Org**. "Arena", "Chatbot Arena", and the Classical Ionic Pillar mark are the intellectual property and trademarks of Arena / arena.ai.

---

## 📑 Table of Contents

- [Overview & What the App Has](#overview--what-the-app-has)
- [How to Use the App](#how-to-use-the-app)
- [Detailed Feature Deep Dives](#detailed-feature-deep-dives)
  - [1. 5-Second Intelligent Auto-Reconnect Engine](#1-5-second-intelligent-auto-reconnect-engine)
  - [2. Authentic Adaptive Branding & Material You Support](#2-authentic-adaptive-branding--material-you-support)
  - [3. Cryptographic Signing & Compatibility (Fix for "Invalid Package")](#3-cryptographic-signing--compatibility-fix-for-invalid-package)
  - [4. Client-Side Security & Privacy Hardening](#4-client-side-security--privacy-hardening)
  - [5. Native Android Platform UX](#5-native-android-platform-ux)
- [Download & Installation Guide](#download--installation-guide)
  - [Step-by-Step Installation](#step-by-step-installation)
  - [Troubleshooting Common Installation Issues](#troubleshooting-common-installation-issues)
- [Technical Specifications & Verification](#technical-specifications--verification)
- [Building from Source](#building-from-source)
- [Project Architecture & Directory Structure](#project-architecture--directory-structure)
- [Authentication Notes & Limitations](#authentication-notes--limitations)
- [License & Attributions](#license--attributions)

---

## 🏛️ Overview & What the App Has

The application is engineered as a clean, single-codebase Android Gradle project (`ai.arena.mobile`) designed to run seamlessly across all modern Android versions (Android 8.0 Oreo through Android 15+).

| Capability | Current Implementation Status |
| :--- | :--- |
| **Connection Architecture** | **100% Standalone** direct HTTPS to `https://arena.ai` (no companion server, proxy, or LAN required) |
| **Android Version Support** | **Android 8.0 (API 26) through Android 15 (API 34/35)** |
| **Branding & Iconography** | **Official Classical Ionic Pillar** vector & raster mipmaps across all screen densities |
| **Offline Resilience** | **5-Second Auto-Reconnect Engine** with AMOLED reconnect screen, live countdown & auto-retry |
| **Packaging & Signing** | **Full APK Signature Scheme v1, v2 & v3** with 4-byte zip alignment (`zipalign`) |
| **Security & Privacy** | **Zero Telemetry**, Geolocation disabled, File access disabled, Cleartext traffic blocked |
| **Navigation & History** | **Predictive Back Navigation** (`OnBackPressedCallback`), strict Navigation Allow-List |
| **User Experience** | **Pull-to-Refresh** (`SwipeRefreshLayout`), **Multi-File Uploads** (`ClipData`), **Cookie Persistence** |

---

## 🎮 How to Use the App

Once installed on your Android device, the app gives you the full Arena benchmarking experience:

1. **Pairwise Blind Battles (Chatbot Arena):**
   - Tap into the **Arena (battle)** tab.
   - Enter your prompt or coding problem into the text box.
   - Two state-of-the-art LLMs (e.g., GPT-4o, Claude 3.5 Sonnet, Gemini 1.5 Pro, Llama 3.1) generate responses anonymously side-by-side.
   - Vote on which model provided the superior answer: **Model A is better**, **Model B is better**, **Tie**, or **Both are bad**.
   - After voting, the model identities are revealed and your vote contributes to LMSYS's live global Elo leaderboard.

2. **Multimodal Vision Battles:**
   - Tap into the **Vision** tab.
   - Use the native file picker to upload one or more benchmark images (diagrams, photos, UI screenshots).
   - Ask questions about the uploaded images to benchmark visual reasoning across frontier models.

3. **Coding & Hard Prompts Arenas:**
   - Benchmark complex algorithmic problems, code refactoring, logic puzzles, and difficult multi-step queries under specialized categories.

4. **Leaderboards & Model Rankings:**
   - Browse the live, crowd-sourced leaderboard table to review model Elo ratings, 95% confidence intervals, and category rankings (Overall, Coding, Hard Prompts, Vision, French, etc.).

5. **Direct Model Chat:**
   - Switch to **Direct Chat** mode when you want to interact directly with a specific LLM without blind voting.

6. **Pull-to-Refresh & Fast Navigation:**
   - Swipe down from anywhere near the top of the screen to reload the current page.
   - Use Android's standard back gesture or back button to navigate backwards through your browsing history without exiting the app prematurely.

---

## 🔍 Detailed Feature Deep Dives

### 1. 5-Second Intelligent Auto-Reconnect Engine

Mobile network connectivity often drops when transitioning between Wi-Fi and mobile data, passing through dead zones, or toggling network settings. Rather than displaying an ugly default Chromium error screen (`net::ERR_INTERNET_DISCONNECTED`), this client features an integrated auto-reconnect engine:

- **Error Interception:** When WebView detects network interruption (`onReceivedError`), it immediately renders an AMOLED `#000000` reconnect view.
- **Visual Design:** Displays the authentic Classical Ionic Pillar mark, an animated spinning circular loader, and a live countdown timer (`Checking in 5s...`).
- **Background Health Probes:** A non-blocking background thread pool (`networkExecutor`) executes lightweight `HEAD` requests to `https://arena.ai` via `HttpURLConnection` every 5 seconds.
- **Zero-Touch Auto-Recovery:** The instant network connectivity is restored (e.g. Wi-Fi re-established or Airplane Mode turned off), the app automatically cancels the timer, dismisses the error view, and loads `https://arena.ai` seamlessly.
- **Manual Override:** A prominent **"Retry Now"** button is also provided for immediate manual reconnection.

```
[Network Dropped / Offline]
         │
         ▼
[Intercept onReceivedError] ──► Render AMOLED Error Card (Pillar + Countdown)
         │
         ▼
[Background Loop (every 5s)] ──► HEAD https://arena.ai
         │
         ├── Connection Failed ──► Wait 5s & update countdown (5..4..3..2..1)
         │
         └── Connection Restored ──► Auto-Reload https://arena.ai (Zero User Touch)
```

---

### 2. Authentic Adaptive Branding & Material You Support

The application delivers a first-class, authentic home screen presence matching modern Android design guidelines:

- **Adaptive Vector Drawables:**
  - Foreground (`@drawable/ic_launcher_foreground.xml`): Vector representation of the Classical Ionic Pillar mark centered on a 108dp adaptive canvas.
  - Background (`@drawable/ic_launcher_background.xml`): Solid AMOLED `#000000` deep black.
  - Themed Monochrome (`@drawable/ic_launcher_monochrome.xml`): Android 13+ (API 33+) dynamic Material You icon that automatically tints to match the user's wallpaper color palette.
- **Dual Adaptive XML Manifestations:**
  - Configured in `res/mipmap-anydpi-v26/ic_launcher.xml` and `ic_launcher_round.xml` to support squircle, circular, teardrop, and rounded square launcher shapes.
- **Comprehensive Density Raster Fallbacks:**
  - Includes pre-rendered 32-bit RGBA icons across all standard Android density buckets: `mdpi` (48x48), `hdpi` (72x72), `xhdpi` (96x96), `xxhdpi` (144x144), and `xxxhdpi` (192x192).
- **Dual Activity & Application Registration:**
  - Registered on both `<application>` and `<activity>` elements in `AndroidManifest.xml` to guarantee correct icon resolution across all OEM launchers (Pixel Launcher, Samsung One UI, Xiaomi HyperOS/MIUI, OnePlus OxygenOS, Nova Launcher).

---

### 3. Cryptographic Signing & Compatibility (Fix for "Invalid Package")

Older Android packaging tools produced APKs signed solely with legacy JAR signing (APK Signature Scheme v1). When installed on devices running **Android 11, 12, 13, 14, or 15**, the system `PackageInstaller` automatically rejects these packages with:
> *"App not installed as package appears to be invalid"*

To resolve this issue, the release pipeline implements:
1. **Multi-Scheme Signing:** The APK is cryptographically signed using both **APK Signature Scheme v1** (JAR signing) and **APK Signature Scheme v2 & v3** (binary APK Signing Block) using official Android SDK `apksigner`.
2. **4-Byte Zip Alignment (`zipalign`):** All 241 stored archive entries (including uncompressed `resources.arsc`) are strictly aligned on 4-byte boundaries, enabling the Android OS to memory-map resources directly from the APK file without copying them to RAM.
3. **Reproducible Community Key:** Release builds are signed with the community keystore valid through the year 2054.

---

### 4. Client-Side Security & Privacy Hardening

The application enforces a hardened, defense-in-depth security configuration:

- **Zero Telemetry or Analytics:** No third-party tracking SDKs (Firebase, Adjust, Mixpanel, Google Analytics, Sentry) are included in the binary.
- **HTML5 Geolocation Disabled:** `WebSettings.setGeolocationEnabled(false)` prevents web scripts from querying physical device GPS coordinates.
- **Local File System Protection:** `setAllowFileAccess(false)`, `setAllowContentAccess(false)`, `setAllowFileAccessFromFileURLs(false)`, and `setAllowUniversalAccessFromFileURLs(false)` prevent web content from reading private device files via `file://` or content URIs.
- **Cleartext Traffic Disabled:** `android:usesCleartextTraffic="false"` strictly forbids non-HTTPS HTTP connections at the Android OS network security layer.
- **Application Backup Disabled:** `android:allowBackup="false"` prevents extraction of session cookies and tokens via Android Debug Bridge (`adb backup`).
- **Navigation Security Allow-List:** Embedded WebView navigation is strictly confined to Arena domains (`arena.ai`, `lmarena.ai`) and authorized OAuth identity providers (`accounts.google.com`, `github.com`, `appleid.apple.com`, `auth0.com`). Any external link is automatically handed off to the user's default system browser via `Intent.ACTION_VIEW`.
- **Single Minimal Permission:** Declares solely `android.permission.INTERNET`. Does not request location, storage, camera, contacts, phone state, or network state.

---

### 5. Native Android Platform UX

- **Predictive Back Navigation:** Migrated from deprecated `onBackPressed()` to AndroidX `OnBackPressedCallback`, preventing navigation glitches on Android 14+ and Android 15/16 (API 34–36).
- **Multi-File Upload Chooser:** Implemented `WebChromeClient.onShowFileChooser` with support for `ClipData` multi-selection, MIME type filtering, and safe cancellation, allowing seamless multi-image uploads for vision battles.
- **Session & Cookie Persistence:** Explicit calls to `CookieManager.getInstance().flush()` during `onPageFinished`, `onPause`, `onStop`, and `onDestroy` guarantee login cookies survive process restarts.
- **Secondary Window & OAuth Support:** `WebChromeClient.onCreateWindow` creates dedicated fullscreen dialog WebViews with third-party cookie support for popup authentication dialogs.
- **Download Management:** Integrated `DownloadListener` delegates file downloads to the system download manager.

---

## 📲 Download & Installation Guide

### Step-by-Step Installation

1. **Uninstall Any Previous Build:**
   If you had an earlier version of the app installed on your phone, uninstall it first. Because release keys changed, Android will reject updates that do not match the previous key.
2. **Download the Verified Release APK:**
   Download the latest release file directly to your phone:  
   👉 **[Download ArenaAI.apk (v1.0.1)](https://github.com/Mr-Nobody-Anonymous/arena-ai-android/releases/download/v1.0.1/ArenaAI.apk)**
3. **Allow Installation from Unknown Sources:**
   - Tap the downloaded `ArenaAI.apk` in Chrome or your phone's **Files / Downloads** app.
   - If prompted *"For your security, your phone is not allowed to install unknown apps from this source"*, tap **Settings** and turn on **Allow from this source**.
4. **Complete Installation:**
   - Tap **Install**. The app will install cleanly in just a few seconds.
5. **Launch Arena:**
   - Look for the **Arena AI** icon (Classical Pillar on black) in your app drawer or home screen and tap to launch.

---

### Troubleshooting Common Installation Issues

| Issue / Error | Cause | Solution |
| :--- | :--- | :--- |
| **"App not installed as package appears to be invalid"** | An older APK built with legacy signing is still installed on the device. | Uninstall the old version from your device first, then install the new APK. |
| **"Install Blocked by Play Protect"** | The APK is an open-source community release built outside Google Play. | Tap **More details** and select **Install anyway**. |
| **"Parse error: There was a problem parsing the package"** | Download was incomplete or corrupted, or device is below Android 8.0. | Verify downloaded file size is `2,820,867 bytes` and re-download if necessary. |
| **"No internet connection detected" screen on launch** | Device is in Airplane mode or lacks an active Wi-Fi / cellular data connection. | Connect to Wi-Fi or mobile data; the app will auto-reconnect within 5 seconds. |

---

## 🔐 Technical Specifications & Verification

Verify the cryptographic integrity of your downloaded APK using standard command-line tools:

| Attribute | Specification |
| :--- | :--- |
| **File Name** | `ArenaAI.apk` |
| **File Size** | `2,820,867 bytes` (~2.82 MB) |
| **SHA-256 Checksum** | `d2cdf96da50bad8145b3fd935b1f99ecbdda7807ab5981aa1fa3e003dc941f1e` |
| **Package ID** | `ai.arena.mobile` |
| **Version** | `1.0.1 (versionCode 2)` |
| **Min SDK** | `API 26 (Android 8.0 Oreo)` |
| **Target SDK** | `API 34 (Android 14)` |
| **Zip Alignment** | Verified 4-byte aligned (all 241 stored archive entries) |
| **Signature Schemes** | APK Signature Scheme v1 (JAR), v2 (APK Signature Block), v3 (Android 9+) |

### Signing Certificate Fingerprints
```text
Owner / Issuer: CN=Arena Mobile Community, OU=Open Source, O=Community, L=San Francisco, ST=CA, C=US
Algorithm:      2048-bit RSA with SHA384withRSA
Validity:       October 11, 2026 to February 26, 2054
SHA-256:        7B:7C:33:2A:78:9C:48:F2:97:95:46:08:11:F6:B7:31:B6:F2:B0:62:29:9C:AD:71:A5:CB:E4:59:EC:E8:2F:49
SHA-1:          A1:B9:F5:28:82:4A:63:0F:AA:2B:77:B5:F7:AF:2A:BB:BF:D7:01:1D
```

To verify on Windows PowerShell:
```powershell
Get-FileHash -Algorithm SHA256 ArenaAI.apk
```

To verify on Linux / macOS:
```bash
sha256sum ArenaAI.apk
```

---

## 🛠️ Building from Source

To compile the Android client locally, ensure you have:
- **JDK 17** or newer
- **Android SDK** with Platform API 34 and Build Tools installed

```bash
# 1. Clone the repository
git clone https://github.com/Mr-Nobody-Anonymous/arena-ai-android.git
cd arena-ai-android/android

# 2. Run unit tests
./gradlew test

# 3. Build a debug APK
./gradlew assembleDebug

# 4. Build a signed release APK
./gradlew assembleRelease
```
The compiled APK will be output to `android/app/build/outputs/apk/release/app-release.apk`.

### Automated Audit Test Suite
The repository includes an automated 35-point integrity and compliance test suite:
```bash
npm test
```
All 35 tests validate security properties, AndroidX settings, adaptive icon vectors, CI configurations, and hygiene gates.

---

## 📁 Project Architecture & Directory Structure

```text
arena-ai-android/
├── .github/
│   ├── workflows/build.yml     # Automated CI pipeline (Gradle build, test, signing verification)
│   ├── dependabot.yml          # Automated dependency security tracking
│   ├── ISSUE_TEMPLATE/         # Bug report & feature request templates
│   └── PULL_REQUEST_TEMPLATE.md# Pull request contribution template
├── android/                    # Single source of truth Android application
│   ├── app/
│   │   ├── build.gradle        # App Gradle configuration (ai.arena.mobile, SDK 34, v1/v2 signing)
│   │   ├── proguard-rules.pro  # R8 / ProGuard optimization & keep rules
│   │   └── src/
│   │       ├── main/
│   │       │   ├── AndroidManifest.xml # Permissions (INTERNET only), launcher icon declarations
│   │       │   ├── java/ai/arena/mobile/
│   │       │   │   └── MainActivity.java # WebView lifecycle, 5s reconnect loop, file uploads
│   │       │   └── res/
│   │       │       ├── drawable/       # ic_launcher_background, ic_launcher_foreground, monochrome
│   │       │       ├── mipmap-anydpi-v26/ # Adaptive icon XML definitions
│   │       │       ├── mipmap-[m|h|xh|xxh|xxxh]dpi/ # Density raster PNGs
│   │       │       └── values/         # colors.xml, strings.xml, themes.xml
│   │       └── test/                   # Java unit test suite
│   ├── gradle/wrapper/         # Gradle 8.2 wrapper binaries and configuration
│   ├── gradle.properties       # AndroidX configuration (android.useAndroidX=true)
│   └── gradlew, gradlew.bat    # Cross-platform Gradle wrapper execution scripts
├── tests/                      # Automated compliance test suite (35/35 passing)
│   ├── runner.js               # Test orchestrator
│   └── test-suite.js           # Audit test cases
├── server.js                   # Optional local reverse proxy (development inspection only)
├── ArenaAI.apk                 # Verified, signed release APK binary
├── SHA256SUMS                  # Cryptographic checksum manifest
├── ANALYSIS_REPORT.md          # Technical audit remediation report
├── CHANGELOG.md                # Detailed release changelog
├── CONTRIBUTING.md             # Contribution guidelines
├── CODE_OF_CONDUCT.md          # Contributor covenant
├── LICENSE                     # Apache License 2.0
├── NOTICE                      # Legal & trademark notices
├── PRIVACY.md                  # Comprehensive privacy statement
└── SECURITY.md                 # Vulnerability disclosure policy
```

---

## 🔑 Authentication Notes & Limitations

- **Email & Password Login:** Fully supported and preserved across app sessions via `CookieManager.getInstance().flush()`.
- **Secondary OAuth Dialogs:** Popup windows spawned by authentication providers are cleanly handled inside modal dialog WebViews via `WebChromeClient.onCreateWindow`.
- **Google Sign-In Policy:** Google enforces strict server-side policies restricting OAuth from embedded WebViews (`Error 403: disallowed_useragent`). The app strips the `; wv` marker from the WebView User-Agent to optimize compatibility. Users encountering Google OAuth restrictions are advised to log in using Email/Password or complete authentication through their default web browser.
- **Optional Development Proxy:** `server.js` is provided purely as an optional desktop utility for local traffic inspection; the Android app connects directly to `https://arena.ai` and does not require this proxy.

---

## 📄 License & Attributions

This project is licensed under the **Apache License, Version 2.0**. See the [LICENSE](LICENSE) file for complete details.

### Trademarks & Attributions
- "Arena", "Chatbot Arena", and the Classical Ionic Pillar mark are trademarks and intellectual property of **Arena / arena.ai** (formerly LMSYS Org).
- Android is a trademark of Google LLC.
- Third-party components and license notices are documented in the [NOTICE](NOTICE) file.
