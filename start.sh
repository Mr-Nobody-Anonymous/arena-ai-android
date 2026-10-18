#!/usr/bin/env bash
# Start the local Arena.ai development proxy (not required by the Android app).
set -euo pipefail

cd "$(dirname "$0")"

if [ ! -d node_modules ]; then
    echo "Installing dependencies (npm ci)..."
    npm ci
fi

# HOST=0.0.0.0 makes the printed LAN URL and QR code reachable from a phone.
exec npm start "$@"
