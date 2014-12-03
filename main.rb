require 'eventmachine'
require "./lib/echos"

class CommandProxy
  def run(check)
    cmd = Echos::Command.new
    cmd.execute!(check)

    q = Echos::Transport.new
    q.publish(cmd.packet.to_s)
  end
end



CONF_FILE = "./config/checks.json"

checks = Echos::Loader.load_file(CONF_FILE)

EM.run do
  checks.each do |check|
    check_object = Echos::Check.new(check.first, check.last)

    EM.add_periodic_timer(check_object.interval) do
      proxy = CommandProxy.new
      proxy.run(check_object)
    end
  end
end

