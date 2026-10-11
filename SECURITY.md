# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0.0 | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it responsibly:

1. **Do not** file a public GitHub issue for sensitive security vulnerabilities.
2. Send an email to the repository maintainer or use GitHub's private vulnerability reporting feature:
   - Navigate to the **Security** tab of the repository.
   - Click **Report a vulnerability**.
3. Include details of the vulnerability:
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if known)
4. We will acknowledge receipt of the report within 48 hours and work on a prompt remediation release.

## Security Architecture & Best Practices

- **Minimal Permissions:** The app requests solely `android.permission.INTERNET`. No location, camera, audio, or storage permissions are declared.
- **Backup Disabled:** `android:allowBackup="false"` is enforced to protect private authentication tokens and cookies from unauthenticated device extraction via `adb backup`.
- **Cleartext Traffic Disabled:** `android:usesCleartextTraffic="false"` blocks all non-HTTPS network requests at the OS level.
- **Local File Scheme Restrictions:** `setAllowFileAccess(false)`, `setAllowContentAccess(false)`, `setAllowFileAccessFromFileURLs(false)`, and `setAllowUniversalAccessFromFileURLs(false)` prevent web content from probing the device file system.
- **Origin Isolation & Navigation Allow-List:** Embedded WebViews are strictly restricted via navigation allow-listing to approved Arena domains (`arena.ai`, `lmarena.ai`) and trusted OAuth endpoints. Outside links open in the system browser via `Intent.ACTION_VIEW`.
- **Cryptographic Signing & Integrity:** Release APKs are signed with APK Signature Schemes v1, v2, and v3 and verified with 4-byte zip alignment (`zipalign`) to prevent tampering and guarantee authentic package provenance.
