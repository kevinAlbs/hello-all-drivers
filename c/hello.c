#include "monitor.h"
#include <mongoc/mongoc.h>
#include <stdio.h>

int main(void) {
    mongoc_init();

    mongoc_client_t *client = mongoc_client_new("mongodb://localhost:27017");
    monitor_install(client);

    printf("Ping from mongo-c-driver %s ...\n", MONGOC_VERSION_S);

    bson_t *command = BCON_NEW("ping", BCON_INT32(1));
    bson_t reply;
    bson_error_t error;
    if (mongoc_client_command_simple(client, "admin", command, NULL, &reply, &error)) {
        printf("Ping from mongo-c-driver %s ... OK\n", MONGOC_VERSION_S);
    } else {
        fprintf(stderr, "ping failed: %s\n", error.message);
        return 1;
    }

    bson_destroy(command);
    bson_destroy(&reply);

    /* TODO: add your code here */

    mongoc_client_destroy(client);
    mongoc_cleanup();

    return 0;
}
