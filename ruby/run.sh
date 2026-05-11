#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# System Ruby on macOS is too old for the current mongo gem; prefer brew Ruby if present.
if BREW_RUBY_BIN="$(brew --prefix ruby 2>/dev/null)/bin" && [ -x "$BREW_RUBY_BIN/ruby" ]; then
    export PATH="$BREW_RUBY_BIN:$PATH"
fi

BUNDLE_PATH=vendor/bundle bundle install --quiet
BUNDLE_PATH=vendor/bundle bundle exec ruby hello.rb
