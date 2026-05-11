import os
import pymongo.monitoring


class CommandMonitor(pymongo.monitoring.CommandListener):
    def started(self, event):
        print(f">> {event.command_name} {event.command}")

    def succeeded(self, event):
        print(f"<< {event.command_name} {event.reply}")

    def failed(self, event):
        pass


def setup_monitoring():
    if os.environ.get("PRINT_MONGODB_COMMANDS"):
        pymongo.monitoring.register(CommandMonitor())
