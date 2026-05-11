#include "monitor.hpp"
#include <bsoncxx/json.hpp>
#include <mongocxx/events/command_started_event.hpp>
#include <mongocxx/events/command_succeeded_event.hpp>
#include <mongocxx/options/apm.hpp>
#include <cstdlib>
#include <iostream>

mongocxx::options::client make_monitor_opts() {
    mongocxx::options::client opts;
    if (!std::getenv("PRINT_MONGODB_COMMANDS")) return opts;

    mongocxx::options::apm apm;
    apm.on_command_started([](const mongocxx::events::command_started_event& e) {
        std::cout << ">> " << e.command_name() << " " << bsoncxx::to_json(e.command()) << "\n";
    });
    apm.on_command_succeeded([](const mongocxx::events::command_succeeded_event& e) {
        std::cout << "<< " << e.command_name() << " " << bsoncxx::to_json(e.reply()) << "\n";
    });
    opts.apm_opts(apm);
    return opts;
}
