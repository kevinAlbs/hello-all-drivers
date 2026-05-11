#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

DRIVER_VERSION="2.3.0"
INSTALL_DIR="$(pwd)/dependencies"
BUILD_TMP="$(pwd)/.build_tmp"

trap 'rm -rf "$BUILD_TMP"' EXIT

mkdir -p "$BUILD_TMP"
cd "$BUILD_TMP"

curl -fLO "https://github.com/mongodb/mongo-c-driver/releases/download/${DRIVER_VERSION}/mongo-c-driver-${DRIVER_VERSION}.tar.gz"
tar xzf "mongo-c-driver-${DRIVER_VERSION}.tar.gz"
cd "mongo-c-driver-${DRIVER_VERSION}"

cmake -S . -B cmake-build \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DENABLE_TESTS=OFF \
    -DENABLE_EXAMPLES=OFF

cmake --build cmake-build --parallel "$(sysctl -n hw.ncpu)"
cmake --install cmake-build

echo "mongo-c-driver ${DRIVER_VERSION} installed to ${INSTALL_DIR}"
