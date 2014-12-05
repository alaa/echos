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
          check_object = Echos::Check.new(check.last.merge(name: check.first))
          EM.add_periodic_timer(check_object.interval) do
            EM.defer(operation(check_object), callback)
          end
        end
      end
    end

    private

    def operation(check)
      Proc.new do
        command = Echos::Command.new
        command.execute!(check)
        command.packet
      end
    end

    def callback
      Proc.new do |packet|
        queue.publish(packet.to_s)
      end
    end
  end
end

