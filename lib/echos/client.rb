require 'eventmachine'
require 'json'

module Echos
  class Client
    # these should be private.
    attr_reader :checks, :queue

    def initialize(checks, queue)
      @checks = checks
      @queue = queue
    end

    def start!
      EM.run do
        checks.each do |check|
          # inside a module there is no need to be explict about it

          check_object = Echos::Check.new(check.last.merge(name: check.first))

          # interval is a data of check that is accessed from outside, it should belong to check object.
          # the interval actually belongs to the eventMachine.

          EM.add_periodic_timer(check_object.interval) do
            EM.defer(operation(check_object), callback)
          end
        end
      end
    end

    private

    def operation(check)
      Proc.new do
        command = Echos::Command.new(check.name, check.command, check.handlers, check.timeout)
        command.execute!
        command.packet
      end
    end

    def callback
      Proc.new do |packet|
        queue.publish(packet.to_json)
      end
    end
  end
end

