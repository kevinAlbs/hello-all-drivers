using System;
using MongoDB.Bson;
using MongoDB.Driver;

var client = new MongoClient("mongodb://localhost:27017");
var db = client.GetDatabase("admin");
var result = db.RunCommand<BsonDocument>(new BsonDocument("ping", 1));
Console.WriteLine(result);
