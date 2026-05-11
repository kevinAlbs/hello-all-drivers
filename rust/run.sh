#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -n "${LOCAL_RUST_DRIVER_PATH:-}" ]; then
    # The repo root is a workspace; the actual crate lives in driver/.
    RUST_CRATE_PATH="$LOCAL_RUST_DRIVER_PATH"
    [ -d "$RUST_CRATE_PATH/driver" ] && RUST_CRATE_PATH="$RUST_CRATE_PATH/driver"
    # Temporarily patch Cargo.toml to use the local crate and restore on exit.
    cp Cargo.toml Cargo.toml.bak
    cp Cargo.lock Cargo.lock.bak
    printf '\n[patch.crates-io]\nmongodb = { path = "%s" }\n' "$RUST_CRATE_PATH" >> Cargo.toml
    trap 'mv Cargo.toml.bak Cargo.toml; mv Cargo.lock.bak Cargo.lock' EXIT
    cargo update -p mongodb --quiet 2>&1 | grep -v "^warning" | grep -v "^$" || true

fi

cargo run --quiet
