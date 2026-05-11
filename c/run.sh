#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -d dependencies ]; then
    echo "dependencies/ not found — run setup.sh first"
    exit 1
fi

export PKG_CONFIG_PATH="$(pwd)/dependencies/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"

cc hello.c -o hello \
    $(pkg-config --cflags --libs mongoc2) \
    -Wl,-rpath,"$(pwd)/dependencies/lib"

./hello
