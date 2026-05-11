#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# System Ruby on macOS is too old for the current mongo gem; prefer brew Ruby if present.
# Try versioned formula first (ruby@3.3), then unversioned (which may be newer).
for _ruby_formula in ruby@3.3 ruby; do
    if _ruby_bin="$(brew --prefix "$_ruby_formula" 2>/dev/null)/bin" && [ -x "$_ruby_bin/ruby" ] && "$_ruby_bin/ruby" --version &>/dev/null; then
        export PATH="$_ruby_bin:$PATH"
        break
    fi
done
unset _ruby_formula _ruby_bin

BUNDLE_PATH=vendor/bundle bundle install --quiet
BUNDLE_PATH=vendor/bundle bundle exec ruby hello.rb
