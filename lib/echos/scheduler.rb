require 'eventmachine'
require 'json'

module Echos
  class Scheduler

    def initialize(checks, queue)
      @checks, @queue = checks, queue
    end

    def start!
      EM.run do
        checks.each do |check_name, options|
          check = Check.new(name: check_name, options: options)
          schedule_check(check)
        end
      end
    end

    private
    attr_reader :checks, :queue

    def schedule_check(check)
      EM.add_periodic_timer(check.interval) do
        EM.defer(operation(check), callback(check))
      end
    end

    def operation(check)
      Proc.new { check.execute! }
    end

    def callback(check)
      Proc.new do |packet|
        queue.publish(packet.to_json)
      end
    end
  end
end

