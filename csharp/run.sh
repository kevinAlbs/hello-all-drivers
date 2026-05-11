#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [ -n "${LOCAL_CSHARP_DRIVER_PATH:-}" ]; then
    LOCAL_NUPKG_DIR=/tmp/local-csharp-driver-nupkgs
    mkdir -p "$LOCAL_NUPKG_DIR"
    # Pack MongoDB.Bson and MongoDB.Driver into a local NuGet feed.
    dotnet pack "$LOCAL_CSHARP_DRIVER_PATH/src/MongoDB.Bson" -c Release -o "$LOCAL_NUPKG_DIR" --nologo -v q /p:NuGetAudit=false 2>/dev/null
    dotnet pack "$LOCAL_CSHARP_DRIVER_PATH/src/MongoDB.Driver" -c Release -o "$LOCAL_NUPKG_DIR" --nologo -v q /p:NuGetAudit=false 2>/dev/null
    # Extract the version that was just packed.
    LOCAL_VERSION=$(ls "$LOCAL_NUPKG_DIR"/MongoDB.Driver.*.nupkg 2>/dev/null \
        | sort -V | tail -1 \
        | sed 's/.*MongoDB\.Driver\.\(.*\)\.nupkg/\1/')
    # Point NuGet at the local feed first, then nuget.org for everything else.
    cat > NuGet.Config <<EOF
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="local" value="$LOCAL_NUPKG_DIR" />
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" />
  </packageSources>
</configuration>
EOF
    # Save the project file and restore it on exit.
    cp hello.csproj hello.csproj.bak
    trap 'rm -f NuGet.Config; mv hello.csproj.bak hello.csproj' EXIT
    # Add both MongoDB.Bson and MongoDB.Driver since the local pack doesn't declare
    # MongoDB.Bson as a transitive dependency.
    dotnet add hello.csproj package MongoDB.Bson --version "$LOCAL_VERSION" --no-restore >/dev/null 2>&1
    dotnet add hello.csproj package MongoDB.Driver --version "$LOCAL_VERSION" --no-restore >/dev/null 2>&1
    dotnet restore --source "$LOCAL_NUPKG_DIR" --source https://api.nuget.org/v3/index.json -v q >/dev/null 2>&1
fi

dotnet run ${LOCAL_CSHARP_DRIVER_PATH:+/p:NuGetAudit=false}
