using System;
using MongoDB.Bson;
using MongoDB.Driver;

var version = typeof(MongoClient).Assembly.GetName().Version!;
var versionStr = $"{version.Major}.{version.Minor}.{version.Build}";

Console.WriteLine($"Ping from MongoDB.Driver {versionStr} ...");

var client = new MongoClient("mongodb://localhost:27017");
var db = client.GetDatabase("admin");
db.RunCommand<BsonDocument>(new BsonDocument("ping", 1));

Console.WriteLine($"Ping from MongoDB.Driver {versionStr} ... OK");
