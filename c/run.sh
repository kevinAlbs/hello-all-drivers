#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -d "$(pwd)/dependencies" ]; then
    PREFIX="$(pwd)/dependencies"
elif PREFIX="$(brew --prefix mongo-c-driver 2>/dev/null)"; then
    : # using Homebrew install
else
    echo "mongo-c-driver not found — run setup.sh or: brew install mongo-c-driver"
    exit 1
fi

cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_PREFIX_PATH="$PREFIX"

cmake --build build

./build/hello
