#!/usr/bin/env bash
# Pre-flight check before pushing a release tag. Verifies that every place a version
# number lives agrees with android/app/build.gradle, and that the tree is committable.
set -euo pipefail

cd "$(dirname "$0")/.."

GRADLE_VERSION=$(grep -E 'versionName "' android/app/build.gradle | head -1 | sed -E 's/.*versionName "([^"]+)".*/\1/')
GRADLE_CODE=$(grep -E 'versionCode [0-9]+' android/app/build.gradle | head -1 | sed -E 's/.*versionCode ([0-9]+).*/\1/')
NPM_VERSION=$(node -p "require('./package.json').version")
LOCK_VERSION=$(node -p "require('./package-lock.json').version")
CHANGELOG_VERSION=$(grep -m1 -E '^## \[[0-9]' CHANGELOG.md | sed -E 's/^## \[([^]]+)\].*/\1/')

echo "build.gradle : $GRADLE_VERSION (code $GRADLE_CODE)"
echo "package.json : $NPM_VERSION"
echo "package-lock : $LOCK_VERSION"
echo "CHANGELOG    : $CHANGELOG_VERSION"

status=0
check() {
    if [ "$1" != "$2" ]; then
        echo "MISMATCH: $3 ($1 != $2)"
        status=1
    fi
}

check "$GRADLE_VERSION" "$NPM_VERSION" "build.gradle versionName vs package.json"
check "$GRADLE_VERSION" "$LOCK_VERSION" "build.gradle versionName vs package-lock"
check "$GRADLE_VERSION" "$CHANGELOG_VERSION" "build.gradle versionName vs CHANGELOG"

if ! grep -q "$GRADLE_VERSION" release_notes.md; then
    echo "MISMATCH: release_notes.md does not mention $GRADLE_VERSION"
    status=1
fi

if [ "$status" -ne 0 ]; then
    echo
    echo "Release checks FAILED. Fix the versions above before tagging."
    exit 1
fi

echo
echo "Versions agree. Next:"
echo "  git tag v$GRADLE_VERSION && git push origin v$GRADLE_VERSION"
echo "(the tag must match versionName; .github/workflows/release.yml re-checks this)"
