const { MongoClient } = require("mongodb");
const { version } = require("mongodb/package.json");

async function main() {
  console.log(`Ping from mongodb ${version} ...`);
  const client = new MongoClient("mongodb://localhost:27017");
  await client.connect();
  await client.db("admin").command({ ping: 1 });
  await client.close();
  console.log(`Ping from mongodb ${version} ... OK`);
}

main().catch(console.error);
