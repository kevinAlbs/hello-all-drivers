#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -n "${LOCAL_GO_DRIVER_PATH:-}" ]; then
    # Use a Go workspace to overlay the local driver checkout over the module proxy.
    go work init . "$LOCAL_GO_DRIVER_PATH"
    trap 'rm -f go.work go.work.sum' EXIT
    go run .
else
    go mod tidy
    go run .
fi
