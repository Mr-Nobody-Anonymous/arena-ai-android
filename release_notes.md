# 🏛️ Arena.ai Android Client v1.0.3 (Community Release)

This release expands ecosystem authentication (Hugging Face, LMSYS, Microsoft, Discord), hardens continuous integration with automated 36-point compliance test execution, and provides the live upgrade target verifying the automated in-app updater.

> **Disclaimer:** This is an independent, community-driven open-source project and is **not affiliated with, maintained by, endorsed by, or sponsored by Arena or LMSYS Org**.

---

## 📲 Verified Release Downloads

| File | Size | SHA-256 Checksum |
| :--- | :--- | :--- |
| **[ArenaAI.apk](ArenaAI.apk)** | 2,825,952 bytes | `6aef57e72714dbd8763cacb0aa2d75d929118f13d38dd619cd6426cd82b15db8` |
| **[SHA256SUMS](SHA256SUMS)** | 79 bytes | Integrity checksum manifest |

---

## 🌟 What's New & Fixed in v1.0.3

### 🌐 Expanded Ecosystem Authentication & Navigation Allow-List
- **Hugging Face (`huggingface.co`):** Direct in-app authentication for Hugging Face model evaluations without dropping session state to external browsers.
- **LMSYS Org (`lmsys.org`, `chat.lmsys.org`):** Smooth browsing of official LMSYS leaderboard rankings and research documentation within the app.
- **Microsoft & Discord SSO:** Added `login.microsoftonline.com`, `live.com`, and `discord.com` to the secure in-app allow-list.

### 📱 Smooth In-App Scrolling & Gestures (Scroll-Up Reload Bug Fixed)
- Disabled `SwipeRefreshLayout`'s touch drag interception (`swipeRefreshLayout.setEnabled(false)`). Touch and drag gestures pass directly to the WebView for uninterrupted, smooth scrolling throughout chat conversations, battle comparisons, and leaderboards.

### 🔄 In-App Automated Self-Updater from GitHub Releases
- On application launch, checks `https://api.github.com/repos/Mr-Nobody-Anonymous/arena-ai-android/releases/latest` in the background.
- Prompts users with a native dialog (`Update Now` / `Later`) when a newer release is published.
- Downloads the APK directly to app cache and triggers installation via `androidx.core.content.FileProvider`.
- Zero permanent UI clutter on the app interface.

### 📁 Enhanced Multi-File & Image Upload Bridge
- Supports `ClipData` multi-selection so multiple benchmark images can be uploaded simultaneously for Vision battles.
- Extended MIME matching for comma-separated types, image wildcards (`image/*`), and extension mapping (`.png`, `.jpg`, `.webp`).

### 🛡️ Hardened CI & Repository Governance
- Added Node.js audit compliance testing step (`npm test`) directly into GitHub Actions CI workflow, enforcing 36 automated checks on every pull request and push.
- Cleaned and merged all open pull requests, with Dependabot grouping configured for streamlined maintenance.

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
