import com.mongodb.ConnectionString;
import com.mongodb.MongoClientSettings;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import java.io.InputStream;
import java.util.Properties;
import org.bson.Document;

public class HelloMongoDB {
    public static void main(String[] args) throws Exception {
        Properties props = new Properties();
        try (InputStream in = HelloMongoDB.class.getResourceAsStream("/driver-version.properties")) {
            props.load(in);
        }
        String version = props.getProperty("version");

        System.out.printf("Ping from mongodb-driver-sync %s ...%n", version);

        MongoClientSettings.Builder settingsBuilder = MongoClientSettings.builder()
            .applyConnectionString(new ConnectionString("mongodb://localhost:27017"));
        if (System.getenv("PRINT_MONGODB_COMMANDS") != null) {
            settingsBuilder.addCommandListener(new CommandMonitor());
        }
        try (MongoClient client = MongoClients.create(settingsBuilder.build())) {
            client.getDatabase("admin").runCommand(new Document("ping", 1));
            System.out.printf("Ping from mongodb-driver-sync %s ... OK%n", version);

            // TODO: add your code here
        }
    }
}
