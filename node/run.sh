#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -n "${LOCAL_NODE_DRIVER_PATH:-}" ]; then
    npm install "$LOCAL_NODE_DRIVER_PATH" --silent
else
    npm install --silent
fi

node hello.js
