import pymongo
from monitor import setup_monitoring

setup_monitoring()

version = pymongo.__version__
print(f"Ping from pymongo {version} ...")
client = pymongo.MongoClient("mongodb://localhost:27017")
client.admin.command("ping")
print(f"Ping from pymongo {version} ... OK")

# TODO: add your code here
