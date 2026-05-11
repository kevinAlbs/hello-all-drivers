#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -n "${LOCAL_CXX_DRIVER_PATH:-}" ]; then
    PREFIX="$LOCAL_CXX_DRIVER_PATH${LOCAL_C_DRIVER_PATH:+;$LOCAL_C_DRIVER_PATH}"
elif [ -d "$(pwd)/dependencies" ]; then
    # Local source build: also needs the C driver it was built against.
    C_DEPS="$(cd "$(dirname "$0")/.." && pwd)/c/dependencies"
    PREFIX="$(pwd)/dependencies${C_DEPS:+;$C_DEPS}"
elif PREFIX="$(brew --prefix mongo-cxx-driver 2>/dev/null)"; then
    : # Homebrew install links its own C driver; no extra prefix needed.
else
    echo "mongo-cxx-driver not found — run setup.sh or: brew install mongo-cxx-driver"
    exit 1
fi

# Clear the cmake cache so find_package re-runs with the current PREFIX.
rm -f build/CMakeCache.txt

cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_PREFIX_PATH="$PREFIX"

cmake --build build

./build/hello
