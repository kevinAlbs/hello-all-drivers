#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

pip install pymongo --quiet
python3 hello.py
