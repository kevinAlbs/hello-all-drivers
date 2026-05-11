import com.mongodb.event.CommandFailedEvent;
import com.mongodb.event.CommandListener;
import com.mongodb.event.CommandStartedEvent;
import com.mongodb.event.CommandSucceededEvent;

public class CommandMonitor implements CommandListener {
    @Override
    public void commandStarted(CommandStartedEvent event) {
        System.out.printf(">> %s %s%n", event.getCommandName(), event.getCommand().toJson());
    }

    @Override
    public void commandSucceeded(CommandSucceededEvent event) {
        System.out.printf("<< %s %s%n", event.getCommandName(), event.getResponse().toJson());
    }

    @Override
    public void commandFailed(CommandFailedEvent event) {}
}
