#!/usr/bin/env bash
#
# Verifies a built Arena AI APK:
#   - APK Signature Scheme v1/v2/v3 and the signing certificate
#   - 4-byte zip alignment of uncompressed entries
#   - package name, version name, version code and permissions
#   - SHA-256 checksum
#
# Usage: scripts/verify-apk.sh [path/to/ArenaAI.apk]
#
set -euo pipefail

APK="${1:-ArenaAI.apk}"

if [ ! -f "$APK" ]; then
  echo "APK not found: $APK" >&2
  exit 1
fi

SDK_ROOT="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-}}"
if [ -z "$SDK_ROOT" ] || [ ! -d "$SDK_ROOT/build-tools" ]; then
  echo "Android SDK build-tools not found. Set ANDROID_HOME or ANDROID_SDK_ROOT." >&2
  exit 1
fi

TOOLS_DIR="$(ls -d "$SDK_ROOT"/build-tools/* 2>/dev/null | sort -V | tail -1)"
if [ -z "$TOOLS_DIR" ]; then
  echo "No build-tools installation found under $SDK_ROOT/build-tools." >&2
  exit 1
fi

echo "=================================================================="
echo " APK:        $APK"
echo " Build tools: $TOOLS_DIR"
echo "=================================================================="

echo
echo "== Signature schemes and certificates =="
"$TOOLS_DIR/apksigner" verify --verbose --print-certs "$APK"

echo
echo "== Zip alignment (4-byte) =="
"$TOOLS_DIR/zipalign" -c -v 4 "$APK"

echo
echo "== Package metadata =="
"$TOOLS_DIR/aapt" dump badging "$APK" | grep -E "^(package|uses-permission|application-label|sdkVersion|targetSdkVersion)" || true

echo
echo "== SHA-256 =="
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum "$APK"
else
  shasum -a 256 "$APK"
fi
