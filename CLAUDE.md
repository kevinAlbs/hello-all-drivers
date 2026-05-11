This repo is intended to be a collection of simple "hello world" examples for each official MongoDB driver.

The following drivers are supported:

- C driver: https://github.com/mongodb/mongo-c-driver
- C++ driver: https://github.com/mongodb/mongo-cxx-driver
- Go driver: https://github.com/mongodb/mongo-go-driver
- Rust driver: https://github.com/mongodb/mongo-rust-driver
- Ruby driver: https://github.com/mongodb/mongo-ruby-driver
- PHP library: https://github.com/mongodb/mongo-php-library
- Python driver: https://github.com/mongodb/mongo-python-driver
- Java driver: https://github.com/mongodb/mongo-java-driver
- C# driver: https://github.com/mongodb/mongo-csharp-driver
- Node driver: https://github.com/mongodb/node-mongodb-native

The examples may assume that a MongoDB server is running on default ports. This can be tested with:

```bash
mongosh --eval "db.runCommand({ping:1})"
```

Each directory has a `run.sh` script to run an example.
