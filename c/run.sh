#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -d dependencies ]; then
    echo "dependencies/ not found — run setup.sh first"
    exit 1
fi

cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_PREFIX_PATH="$(pwd)/dependencies"

cmake --build build

./build/hello
