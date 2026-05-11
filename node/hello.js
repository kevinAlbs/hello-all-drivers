const { MongoClient } = require("mongodb");

async function main() {
  const client = new MongoClient("mongodb://localhost:27017");
  await client.connect();
  const result = await client.db("admin").command({ ping: 1 });
  console.log(result);
  await client.close();
}

main().catch(console.error);
