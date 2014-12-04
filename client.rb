require "./lib/echos"

CONF_FILE = "./config/checks.json"

checks = Echos::Loader.load_file(CONF_FILE)
queue = Echos::Transport.new

client = Echos::Client.new(checks, queue)
client.start!

