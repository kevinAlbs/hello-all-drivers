<?php
use MongoDB\Driver\Monitoring\CommandSubscriber;
use MongoDB\Driver\Monitoring\CommandStartedEvent;
use MongoDB\Driver\Monitoring\CommandSucceededEvent;
use MongoDB\Driver\Monitoring\CommandFailedEvent;

class Monitor implements CommandSubscriber {
    public function commandStarted(CommandStartedEvent $event): void {
        echo ">> " . $event->getCommandName() . " " . json_encode($event->getCommand()) . "\n";
    }

    public function commandSucceeded(CommandSucceededEvent $event): void {
        echo "<< " . $event->getCommandName() . " " . json_encode($event->getReply()) . "\n";
    }

    public function commandFailed(CommandFailedEvent $event): void {}
}

function setup_monitoring(): void {
    if (!getenv("PRINT_MONGODB_COMMANDS")) return;
    \MongoDB\Driver\Monitoring\addSubscriber(new Monitor());
}
