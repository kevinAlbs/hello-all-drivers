import pymongo

client = pymongo.MongoClient("mongodb://localhost:27017")
result = client.admin.command("ping")
print(result)
