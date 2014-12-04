require 'eventmachine'

module Echos
  class Client
    attr_reader :checks, :queue

    def initialize(checks, queue)
      @checks = checks
      @queue = queue
    end

    def start!
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

    end
  end
end

