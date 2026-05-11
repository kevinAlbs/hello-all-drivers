# hello-all-drivers

Minimal "hello world" examples for each MongoDB driver. Each example runs a ping command.

## Prerequisites

A running MongoDB server on the default port:
```bash
mongosh --eval "db.runCommand({ping:1})"
```

## Running an example

Each subdirectory has a `run.sh` that installs dependencies and runs the example. Example:

```bash
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

## Command monitoring

Set `PRINT_MONGODB_COMMANDS=1` to print every outgoing command and its reply:

```bash
PRINT_MONGODB_COMMANDS=1 bash go/run.sh
```

Example output:
```
Ping from mongo-go-driver v2.6.0 ...
>> ping {"ping": 1, "$db": "admin", ...}
<< ping {"ok": 1.0, ...}
Ping from mongo-go-driver v2.6.0 ... OK
```

The monitoring code lives in a separate file in each subdirectory (`monitor.c`,
`monitor.cpp`, `monitor.go`, `monitor.rs`, `monitor.rb`, `Monitor.php`,
`monitor.py`, `CommandMonitor.java`, `Monitor.cs`, `monitor.js`) so the main
hello file stays focused on the driver usage.

## Adding your own code

Make a branch of this repo.

Edit the examples. There is a TODO comment suggesting where to modify.


## Updating driver versions

Use the `/update-deps` Claude Code command (requires [Claude Code](https://claude.ai/code)):

```bash
/update-deps        # update all drivers
/update-deps c      # update only the C driver
/update-deps go     # update only the Go driver
```

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
