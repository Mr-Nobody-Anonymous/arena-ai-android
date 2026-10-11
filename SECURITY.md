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

- **Minimal Permissions:** The app requests only `android.permission.INTERNET`.
- **Backup Disabled:** `android:allowBackup="false"` is enforced to protect private authentication tokens and cookies from unauthenticated device extraction.
- **Cleartext Traffic Disabled:** `android:usesCleartextTraffic="false"` blocks all non-HTTPS network requests at the OS level.
- **Local File Scheme Restrictions:** `setAllowFileAccess(false)`, `setAllowContentAccess(false)`, `setAllowFileAccessFromFileURLs(false)`, and `setAllowUniversalAccessFromFileURLs(false)` are active.
- **Origin Isolation:** Embedded WebViews are strictly restricted via navigation allow-listing to approved Arena domains and trusted OAuth endpoints.
