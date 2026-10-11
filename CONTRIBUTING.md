# Contributing to Arena.ai Android Client

Thank you for your interest in contributing to the unofficial Arena.ai Android client!

## Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md) in all community interactions.

## How to Contribute

1. **Fork the repository** on GitHub.
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/<your-username>/arena-ai-android.git
   cd arena-ai-android
   ```
3. **Create a topic branch**:
   ```bash
   git checkout -b feature/my-new-feature
   ```
4. **Make your changes**:
   - Ensure changes in `android/` follow Android best practices.
   - Run unit tests and verify the Gradle build compiles cleanly.
5. **Commit your changes**:
   - Use clear, conventional commit messages (e.g., `feat: ...`, `fix: ...`, `docs: ...`).
6. **Push to your branch and submit a Pull Request**:
   - Provide a clear description of the problem solved and the testing performed.

## Building from Source

### Prerequisites
- JDK 17 or higher
- Android SDK (API 34/35 platform and build-tools)
- Gradle 8.2+ (or use the included Gradle wrapper)

### Build Commands
Navigate to the `android/` directory:
```bash
cd android

# Build debug APK
./gradlew assembleDebug

# Build release APK
./gradlew assembleRelease

# Run unit tests
./gradlew test
```

APK outputs are placed in `android/app/build/outputs/apk/`.
