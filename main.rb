require "./lib/echos"

CONF_FILE = "./config/checks.json"

checks = Echos::Loader.load_file(CONF_FILE)

checks.each do |check|
  check = Echos::Check.new(check.first, check.last)

  cmd = Echos::Command.new
  cmd.execute!(check)
  puts cmd.packet.to_s

  q = Echos::Transport.new
  q.publish(cmd.packet.to_s)
end

