function setupMonitoring(client) {
    if (!process.env.PRINT_MONGODB_COMMANDS) return;
    client.on("commandStarted", e => console.log(`>> ${e.commandName} ${JSON.stringify(e.command)}`));
    client.on("commandSucceeded", e => console.log(`<< ${e.commandName} ${JSON.stringify(e.reply)}`));
}

module.exports = { setupMonitoring };
