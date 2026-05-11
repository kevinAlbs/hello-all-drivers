using System;
using MongoDB.Bson;
using MongoDB.Driver;
using MongoDB.Driver.Core.Events;

public static class Monitor {
    public static MongoClientSettings Configure(MongoClientSettings settings) {
        if (Environment.GetEnvironmentVariable("PRINT_MONGODB_COMMANDS") == null)
            return settings;
        settings.ClusterConfigurator = cb => {
            cb.Subscribe<CommandStartedEvent>(e =>
                Console.WriteLine($">> {e.CommandName} {e.Command.ToJson()}"));
            cb.Subscribe<CommandSucceededEvent>(e =>
                Console.WriteLine($"<< {e.CommandName} {e.Reply.ToJson()}"));
        };
        return settings;
    }
}
