require "./lib/echos"

CONF_FILE = "./config/checks.json"

checks = Echos::Loader.load_file(CONF_FILE)
bus = Echos::Bus.new(Echos::Queue::RabbitMQ)

client = Echos::Client.new(checks, bus)
client.start!

