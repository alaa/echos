require 'eventmachine'
require "./lib/echos"

CONF_FILE = "./config/checks.json"

checks = Echos::Loader.load_file(CONF_FILE)

EM.run do

  checks.each do |check|
    check = Echos::Check.new(check.first, check.last)

    puts "+++ Registering #{check.name} with EventMachine +++ "

    Thread.new {
      EM.add_periodic_timer(check.interval) do
        cmd = Echos::Command.new
        cmd.execute!(check)

        q = Echos::Transport.new
        q.publish(cmd.packet.to_s)
      end
    }

  end

end

