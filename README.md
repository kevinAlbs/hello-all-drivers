# hello-all-drivers

Minimal "hello world" examples for each official MongoDB driver. Each example
connects to a local MongoDB server and runs a ping command.

## Prerequisites

A running MongoDB server on the default port:
```
mongosh --eval "db.runCommand({ping:1})"
```

## Running an example

Every subdirectory has a `run.sh` that installs dependencies and runs the example:

```
bash c/run.sh
bash go/run.sh
bash rust/run.sh
bash php/run.sh
bash python/run.sh
bash java/run.sh
bash csharp/run.sh
bash node/run.sh
```

Expected output format:
```
Ping from <driver> <version> ...
Ping from <driver> <version> ... OK
```

### C driver: first-time setup

The C example builds `mongo-c-driver` from source and installs it locally.
Run `setup.sh` once before `run.sh`:

```
bash c/setup.sh   # downloads and builds mongo-c-driver into c/dependencies/
bash c/run.sh
```

Alternatively, `run.sh` will use a Homebrew install if one is present:
```
brew install mongo-c-driver
bash c/run.sh
```

## Adding your own code

Each example has a `# TODO: add your code here` comment placed after the
successful ping, with the client still in scope. That is the intended edit point.

## Updating driver versions

Use the `/update-deps` Claude Code command (requires [Claude Code](https://claude.ai/code)):

```
/update-deps        # update all drivers
/update-deps c      # update only the C driver
/update-deps go     # update only the Go driver
```

The command knows where each driver pins its version and which package-manager
command to run. After updating, it verifies each example still runs.

### Updating manually

| Driver | Where the version lives | How to update |
|--------|------------------------|---------------|
| C | `c/setup.sh` `DRIVER_VERSION=` | Edit the variable, delete `c/dependencies/`, rerun `setup.sh` |
| Go | `go/go.mod` | `cd go && go get go.mongodb.org/mongo-driver/v2@latest && go mod tidy` |
| Rust | `rust/Cargo.toml` major pin | `cd rust && cargo update -p mongodb` |
| PHP | `php/composer.json` | `cd php && composer update mongodb/mongodb` |
| Python | none (always latest on fresh venv) | `cd python && .venv/bin/pip install --upgrade pymongo` |
| Java | `java/pom.xml` `<mongodb-driver.version>` | Edit the property, Maven re-downloads on next build |
| C# | `csharp/hello.csproj` | `cd csharp && dotnet add package MongoDB.Driver` |
| Node | `node/package.json` | `cd node && npm install mongodb@latest` |

## CI

The repository uses GitHub Actions (`.github/workflows/ci.yml`). It runs on
every push and pull request using a `macos-latest` runner so that
`brew install mongo-c-driver` works without building from source.

The workflow:
1. Installs PHP + the `mongodb` PECL extension via `shivammathur/setup-php`
2. Installs and starts MongoDB via `mongodb/brew`
3. Installs the C driver via `brew install mongo-c-driver`
4. Runs `bash <driver>/run.sh` for each of the eight drivers
