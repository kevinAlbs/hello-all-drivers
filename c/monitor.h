#ifndef MONITOR_H
#define MONITOR_H
#include <mongoc/mongoc.h>
void monitor_install(mongoc_client_t *client);
#endif
