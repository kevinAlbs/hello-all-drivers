require "mongo"

version = Mongo::VERSION
puts "Ping from mongo-ruby-driver #{version} ..."

client = Mongo::Client.new(["localhost:27017"])
client.database.command(ping: 1)
client.close

puts "Ping from mongo-ruby-driver #{version} ... OK"

# TODO: add your code here
