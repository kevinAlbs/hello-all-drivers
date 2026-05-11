package main

import (
	"context"
	"fmt"
	"log"
	"runtime/debug"

	"go.mongodb.org/mongo-driver/v2/bson"
	"go.mongodb.org/mongo-driver/v2/mongo"
	"go.mongodb.org/mongo-driver/v2/mongo/options"
)

func driverVersion() string {
	info, ok := debug.ReadBuildInfo()
	if !ok {
		return "unknown"
	}
	for _, dep := range info.Deps {
		if dep.Path == "go.mongodb.org/mongo-driver/v2" {
			return dep.Version
		}
	}
	return "unknown"
}

func main() {
	version := driverVersion()
	fmt.Printf("Ping from mongo-go-driver %s ...\n", version)

	client, err := mongo.Connect(options.Client().ApplyURI("mongodb://localhost:27017").SetMonitor(makeMonitor()))
	if err != nil {
		log.Fatal(err)
	}
	defer client.Disconnect(context.Background())

	err = client.Database("admin").RunCommand(context.Background(), bson.D{{Key: "ping", Value: 1}}).Err()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Ping from mongo-go-driver %s ... OK\n", version)

	// TODO: add your code here
}
