Update the MongoDB driver dependency in one or more subdirectories to a new version.

Usage: /update-deps [driver]

If a driver name is given (c, go, rust, php, python, java, csharp, node), update only that driver.
If no argument is given, update all drivers.

## Per-driver instructions

### C (`c/`)
The version is hardcoded in `c/setup.sh` as `DRIVER_VERSION="x.y.z"`.
1. Find the latest release at https://github.com/mongodb/mongo-c-driver/releases
2. Edit `DRIVER_VERSION` in `c/setup.sh` to the new version.
3. Delete `c/dependencies/` so the next run rebuilds from the new source.
4. Run `bash c/setup.sh` to download and install the new version.
5. Run `bash c/run.sh` to verify.

### Go (`go/`)
1. Run: `cd go && go get go.mongodb.org/mongo-driver/v2@latest && go mod tidy`
2. Run `bash go/run.sh` to verify.

### Rust (`rust/`)
The `Cargo.toml` pins a major version (`mongodb = "3"`). To update within the major:
- Run: `cd rust && cargo update -p mongodb`
To pin to an exact new version, edit `Cargo.toml` first, then run `cargo update`.
Run `bash rust/run.sh` to verify.

### PHP (`php/`)
1. Run: `cd php && composer update mongodb/mongodb`
2. Run `bash php/run.sh` to verify.

### Python (`python/`)
Python has no pinned version; `pip install pymongo` always fetches the latest on a fresh venv.
To force an upgrade in an existing venv:
- Run: `cd python && .venv/bin/pip install --upgrade pymongo`
Run `bash python/run.sh` to verify.

### Java (`java/`)
The version is set as `<mongodb-driver.version>` in `java/pom.xml`.
1. Find the latest version at https://central.sonatype.com/artifact/org.mongodb/mongodb-driver-sync
2. Edit `<mongodb-driver.version>` in `java/pom.xml`.
3. Run `bash java/run.sh` to verify (Maven re-downloads automatically).

### C# (`csharp/`)
1. Run: `cd csharp && dotnet add package MongoDB.Driver`
   This updates `hello.csproj` to the latest compatible version.
2. Run `bash csharp/run.sh` to verify.

### Node (`node/`)
1. Run: `cd node && npm install mongodb@latest`
2. Run `bash node/run.sh` to verify.

## After updating

Run all examples to confirm everything still works:
```
for dir in c go rust php python java csharp node; do
    echo "--- $dir ---"
    bash "$dir/run.sh"
done
```

Then commit the changed lock files and version pins.
