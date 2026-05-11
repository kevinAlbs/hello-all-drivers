#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

composer install --quiet
php hello.php
