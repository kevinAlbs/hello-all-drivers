#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -d .venv ]; then
    python3 -m venv .venv
fi

if [ -n "${LOCAL_PYTHON_DRIVER_PATH:-}" ]; then
    .venv/bin/pip install -e "$LOCAL_PYTHON_DRIVER_PATH" --quiet
else
    .venv/bin/pip install --force-reinstall pymongo --quiet
fi

.venv/bin/python3 hello.py
