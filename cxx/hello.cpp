#include <mongocxx/client.hpp>
#include <mongocxx/config/version.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <bsoncxx/json.hpp>
#include <iostream>

int main() {
    mongocxx::instance inst{};
    mongocxx::client client{mongocxx::uri{"mongodb://localhost:27017"}};

    std::cout << "Ping from mongo-cxx-driver " << MONGOCXX_VERSION_STRING << " ...\n";

    client["admin"].run_command(bsoncxx::from_json(R"({"ping": 1})"));

    std::cout << "Ping from mongo-cxx-driver " << MONGOCXX_VERSION_STRING << " ... OK\n";

    // TODO: add your code here

    return 0;
}
