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
bash cxx/run.sh
bash go/run.sh
bash rust/run.sh
bash ruby/run.sh
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

The C and C++ examples build `mongo-c-driver` / `mongo-cxx-driver` from source
on first run if the library is not already installed. Pass
`brew install mongo-c-driver mongo-cxx-driver` to skip the source build.

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

### Updating manually

| Driver | Where the version lives | How to update |
|--------|------------------------|---------------|
| C | `c/run.sh` `DRIVER_VERSION=` | Edit the variable, delete `c/dependencies/`, rerun `run.sh` |
| C++ | `cxx/run.sh` `DRIVER_VERSION=` | Edit the variable, delete `cxx/dependencies/`, rerun `run.sh` |
| Go | `go/go.mod` | `cd go && go get go.mongodb.org/mongo-driver/v2@latest && go mod tidy` |
| Rust | `rust/Cargo.toml` major pin | `cd rust && cargo update -p mongodb` |
| Ruby | `ruby/Gemfile` | `cd ruby && BUNDLE_PATH=vendor/bundle bundle update mongo` |
| PHP | `php/composer.json` | `cd php && composer update mongodb/mongodb` |
| Python | none (always latest on fresh venv) | `cd python && .venv/bin/pip install --upgrade pymongo` |
| Java | `java/pom.xml` `<mongodb-driver.version>` | Edit the property, Maven re-downloads on next build |
| C# | `csharp/hello.csproj` | `cd csharp && dotnet add package MongoDB.Driver` |
| Node | `node/package.json` | `cd node && npm install mongodb@latest` |

## CI

The repository uses GitHub Actions (`.github/workflows/ci.yml`). It runs on
every push and pull request using a `macos-latest` runner so that
`brew install mongo-c-driver` and `brew install mongo-cxx-driver` work natively.

The workflow:
1. Installs PHP + the `mongodb` PECL extension via `shivammathur/setup-php`
2. Installs Ruby 3.3 via `ruby/setup-ruby`
3. Installs and starts MongoDB via `mongodb/brew`
4. Installs the C and C++ drivers via Homebrew
5. Runs `bash <driver>/run.sh` for all ten drivers
