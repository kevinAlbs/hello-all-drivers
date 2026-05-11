import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import org.bson.Document;

public class HelloMongoDB {
    public static void main(String[] args) {
        try (MongoClient client = MongoClients.create("mongodb://localhost:27017")) {
            Document result = client.getDatabase("admin").runCommand(new Document("ping", 1));
            System.out.println(result.toJson());
        }
    }
}
