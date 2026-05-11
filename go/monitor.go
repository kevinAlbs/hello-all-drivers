package main

import (
	"context"
	"fmt"
	"os"

	"go.mongodb.org/mongo-driver/v2/event"
)

func makeMonitor() *event.CommandMonitor {
	if os.Getenv("PRINT_MONGODB_COMMANDS") == "" {
		return nil
	}
	return &event.CommandMonitor{
		Started: func(_ context.Context, e *event.CommandStartedEvent) {
			fmt.Printf(">> %s %s\n", e.CommandName, e.Command)
		},
		Succeeded: func(_ context.Context, e *event.CommandSucceededEvent) {
			fmt.Printf("<< %s %s\n", e.CommandName, e.Reply)
		},
	}
}
