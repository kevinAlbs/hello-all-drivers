const { MongoClient } = require("mongodb");
const { version } = require("mongodb/package.json");
const { setupMonitoring } = require("./monitor");

async function main() {
  console.log(`Ping from mongodb ${version} ...`);
  const client = new MongoClient("mongodb://localhost:27017", { monitorCommands: true });
  setupMonitoring(client);
  await client.connect();
  await client.db("admin").command({ ping: 1 });
  console.log(`Ping from mongodb ${version} ... OK`);

  // TODO: add your code here

  await client.close();
}

main().catch(console.error);
