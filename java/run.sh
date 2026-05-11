#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

mvn -q package -DskipTests
java -jar target/hello-java-1.0-SNAPSHOT.jar
