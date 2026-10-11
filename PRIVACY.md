# Privacy Policy

**Effective Date:** October 11, 2026  
**Application:** Arena.ai Unofficial Android Client (`ai.arena.mobile`)

This privacy policy explains how data is handled by the Arena.ai mobile client application.

---

## 1. Zero Telemetry & Zero Data Collection

The Arena.ai Android application itself **does not collect, log, track, or transmit any personal data, analytics, crash logs, or telemetry** to any third-party or developer servers.
- No analytics SDKs (e.g., Firebase, Google Analytics, Mixpanel, Adjust, Sentry) are bundled.
- No background trackers, ad networks, or device fingerprinting libraries exist in the application.
- There are no custom middleman servers or proxy relays required for normal mobile usage.

---

## 2. Direct Network Communication & Connectivity Monitoring

The application functions as a dedicated, standalone browser interface connecting directly over encrypted HTTPS to **[https://arena.ai](https://arena.ai)**.
- All network requests, API queries, model battle prompts, votes, and chat interactions travel directly between your Android device and Arena's official infrastructure.
- As with any standard web browser visiting `https://arena.ai`, Arena and its content delivery network (Cloudflare) will see your device's public IP address, TLS handshake, and standard browser headers.
- **Offline Reconnection Probing:** When the device loses internet connectivity, the application's auto-reconnect engine periodically issues minimal HTTP HEAD requests directly to `https://arena.ai` on a background thread solely to test connectivity before restoring the page. No tracking parameters, identifiers, or personal tokens are included in these health checks.

---

## 3. Client-Side Privacy Controls

The application enforces strict client-side privacy safeguards inside the WebView engine:

| Control | Implementation | Purpose |
|---|---|---|
| **Geolocation Disabled** | `WebSettings.setGeolocationEnabled(false)` | Prevents websites and scripts from requesting physical GPS / coordinate location via the HTML5 Geolocation API. |
| **Local File Access Blocked** | `WebSettings.setAllowFileAccess(false)`, `setAllowContentAccess(false)` | Blocks JavaScript from accessing private local files on your device via `file://` or content providers. |
| **Clean Chrome User-Agent** | Standard Android Chrome User-Agent string | Eliminates custom application wrapper signatures from HTTP request headers. |
| **Navigation Allow-List** | Strict host matching in `WebViewClient` | Any link navigating outside Arena (`arena.ai`, `lmarena.ai`) or supported OAuth identity providers is automatically handed off to the system web browser. |
| **Isolated Local Storage** | Standard Android private sandbox | Session cookies and local storage tokens are held in private app storage (`/data/data/ai.arena.mobile/`) with `android:allowBackup="false"` to prevent automated adb data extraction. |

---

## 4. Permissions Requested

The application requests only a single Android permission:
- `android.permission.INTERNET`: Required solely to establish HTTPS connections to `https://arena.ai`.

The app **does not request** or use:
- Location (`ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`)
- Camera (`CAMERA`)
- Audio recording (`RECORD_AUDIO`)
- Storage reading/writing (`READ_EXTERNAL_STORAGE`, `WRITE_EXTERNAL_STORAGE`)
- Phone state (`READ_PHONE_STATE`)
- Network state (`ACCESS_NETWORK_STATE`)

---

## 5. Contact & Questions

If you have questions about this privacy statement or wish to inspect the implementation, the complete source code is publicly accessible and auditable on GitHub:  
[https://github.com/Mr-Nobody-Anonymous/arena-ai-android](https://github.com/Mr-Nobody-Anonymous/arena-ai-android)
