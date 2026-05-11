#include "monitor.h"
#include <stdio.h>
#include <stdlib.h>

static void on_started(const mongoc_apm_command_started_t *event) {
    char *cmd = bson_as_relaxed_extended_json(mongoc_apm_command_started_get_command(event), NULL);
    printf(">> %s %s\n", mongoc_apm_command_started_get_command_name(event), cmd);
    bson_free(cmd);
}

static void on_succeeded(const mongoc_apm_command_succeeded_t *event) {
    char *reply = bson_as_relaxed_extended_json(mongoc_apm_command_succeeded_get_reply(event), NULL);
    printf("<< %s %s\n", mongoc_apm_command_succeeded_get_command_name(event), reply);
    bson_free(reply);
}

void monitor_install(mongoc_client_t *client) {
    if (!getenv("PRINT_MONGODB_COMMANDS")) return;
    mongoc_apm_callbacks_t *cbs = mongoc_apm_callbacks_new();
    mongoc_apm_set_command_started_cb(cbs, on_started);
    mongoc_apm_set_command_succeeded_cb(cbs, on_succeeded);
    mongoc_client_set_apm_callbacks(client, cbs, NULL);
    mongoc_apm_callbacks_destroy(cbs);
}
