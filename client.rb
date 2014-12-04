require 'eventmachine'
require "./lib/echos"

class CommandProxy
  def run(check)
    Proc.new do
      cmd = Echos::Command.new
      cmd.execute!(check)
    end
  end

  def transport
    Proc.new do |cmd|
      q = Echos::Transport.new
      q.publish(cmd.packet.to_s)
    end
  end
end

CONF_FILE = "./config/checks.json"

checks = Echos::Loader.load_file(CONF_FILE)
queue = Echos::Transport.new

EM.run do

  checks.each do |check|
    check_object = Echos::Check.new(check.first, check.last)

    EM.add_periodic_timer(check_object.interval) do

      operation = Proc.new {
        command = Echos::Command.new
        command.execute!(check_object)
        command.packet
      }

      callback = Proc.new { |packet|
        queue.publish(packet.to_s)
      }

      EM.defer(operation, callback)
    end

  end
end

