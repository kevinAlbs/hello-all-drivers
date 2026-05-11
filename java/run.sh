#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -n "${LOCAL_JAVA_DRIVER_PATH:-}" ]; then
    # Publish all driver modules to the local Maven repo.
    (cd "$LOCAL_JAVA_DRIVER_PATH" && ./gradlew publishToMavenLocal -x test -q)
    # Read the version from gradle.properties.
    LOCAL_VERSION=$(grep '^version=' "$LOCAL_JAVA_DRIVER_PATH/gradle.properties" | cut -d= -f2)
    mvn -q package -DskipTests -Dmongodb-driver.version="$LOCAL_VERSION"
else
    mvn -q package -DskipTests
fi

java -jar target/hello-java-1.0-SNAPSHOT.jar
