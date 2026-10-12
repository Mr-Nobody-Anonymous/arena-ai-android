# 🏛️ Arena.ai Android Client v1.0.2 (Community Release)

This release resolves the scroll-up reload issue, enhances multi-file and image uploading for Vision battles, and introduces an automated in-app updater that checks for GitHub releases and allows users to update directly inside the application.

> **Disclaimer:** This is an independent, community-driven open-source project and is **not affiliated with, maintained by, endorsed by, or sponsored by Arena or LMSYS Org**.

---

## 📲 Verified Release Downloads

| File | Size | SHA-256 Checksum |
| :--- | :--- | :--- |
| **[ArenaAI.apk](ArenaAI.apk)** | 2,826,043 bytes | `730c8aa159dcc9d568491c24d821dfb894df9a5447d70c644351c693b1291fd6` |
| **[SHA256SUMS](SHA256SUMS)** | 79 bytes | Integrity checksum manifest |

---

## 🌟 What's New & Fixed in v1.0.2

### 📱 Smooth In-App Scrolling & Gestures (Scroll-Up Reload Bug Fixed)
- **Problem Resolved:** Previously, dragging down to scroll up through chat history, battle responses, or leaderboards triggered `SwipeRefreshLayout`'s pull-to-refresh mechanism, instantly reloading `https://arena.ai` and discarding conversations, prompt drafts, and uploaded images.
- **Fix:** Disabled `SwipeRefreshLayout`'s touch drag interception (`swipeRefreshLayout.setEnabled(false)` and `swipeRefreshLayout.setOnChildScrollUpCallback((parent, child) -> true)`). Touch and drag gestures now pass directly to the WebView for uninterrupted, smooth scrolling throughout all views.

### 🔄 In-App Automated Self-Updater from GitHub Releases
- **Automatic Background Checks:** Whenever the app finishes loading, it checks `https://api.github.com/repos/Mr-Nobody-Anonymous/arena-ai-android/releases/latest` in a lightweight background thread.
- **Native User Prompt:** When a newer release is published on GitHub, a clean native `AlertDialog` prompts the user with:
  > **Update Available**  
  > *A new version of Arena AI (vX.X.X) is available with fixes and updates.*  
  > *Would you like to download and install this update?*  
  > **[Update Now]** / **[Later]**
- **Direct Download & Installation:** Downloads the verified release APK directly into the app's secure cache and triggers Android's system package installer using `androidx.core.content.FileProvider`.
- **Zero Permanent UI Clutter:** Does not add any intrusive toolbars or buttons to the interface.

### 📁 Enhanced Multi-File & Image Upload Bridge
- **Intelligent MIME Handling:** Correctly handles comma-separated MIME types, extension mapping (e.g. `.png`, `.jpg`), and image wildcards (`image/*`).
- **Multi-File Selection:** Supports `ClipData` multi-selection so multiple benchmark images can be uploaded simultaneously for Vision battles.
- **Safe Lifecycle Callbacks:** Prevents file chooser callbacks from becoming stranded if file selection is cancelled.

---

## 🔍 Cryptographic Signing & Verification

The release APK is signed with the community release key:

- **Signer:** `CN=Arena Mobile Community, OU=Open Source, O=Community, L=San Francisco, ST=CA, C=US`
- **Certificate Validity:** October 11, 2026 → February 26, 2054
- **SHA-256 Certificate Fingerprint:**  
  `7B:7C:33:2A:78:9C:48:F2:97:95:46:08:11:F6:B7:31:B6:F2:B0:62:29:9C:AD:71:A5:CB:E4:59:EC:E8:2F:49`
- **SHA-1 Certificate Fingerprint:**  
  `A1:B9:F5:28:82:4A:63:0F:AA:2B:77:B5:F7:AF:2A:BB:BF:D7:01:1D`
- **Zip Alignment & Signature Schemes:** 100% verified 4-byte alignment across all stored entries, with full APK Signature Scheme v1, v2, and v3 (Android 11–15 compatible).
