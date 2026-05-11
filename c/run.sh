#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

DRIVER_VERSION="2.3.0"

if [ -d "$SCRIPT_DIR/dependencies" ]; then
    PREFIX="$SCRIPT_DIR/dependencies"
elif PREFIX="$(brew --prefix mongo-c-driver 2>/dev/null)"; then
    : # using Homebrew install
else
    echo "Building mongo-c-driver ${DRIVER_VERSION} from source..."
    BUILD_TMP="$SCRIPT_DIR/.build_tmp"
    trap 'rm -rf "$BUILD_TMP"' EXIT
    mkdir -p "$BUILD_TMP"
    (
        cd "$BUILD_TMP"
        curl -fLO "https://github.com/mongodb/mongo-c-driver/releases/download/${DRIVER_VERSION}/mongo-c-driver-${DRIVER_VERSION}.tar.gz"
        tar xzf "mongo-c-driver-${DRIVER_VERSION}.tar.gz"
        cd "mongo-c-driver-${DRIVER_VERSION}"
        cmake -S . -B cmake-build \
            -DCMAKE_INSTALL_PREFIX="$SCRIPT_DIR/dependencies" \
            -DCMAKE_BUILD_TYPE=Release \
            -DENABLE_TESTS=OFF \
            -DENABLE_EXAMPLES=OFF
        cmake --build cmake-build --parallel "$(sysctl -n hw.ncpu)"
        cmake --install cmake-build
    )
    PREFIX="$SCRIPT_DIR/dependencies"
fi

cmake -S "$SCRIPT_DIR" -B "$SCRIPT_DIR/build" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_PREFIX_PATH="$PREFIX"

cmake --build "$SCRIPT_DIR/build"

"$SCRIPT_DIR/build/hello"
