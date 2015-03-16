require 'eventmachine'

module Echos
  class Scheduler
    def initialize(checks, queue)
      @checks, @queue = checks, queue
    end

    def start!
      EM.run do
        check_objects.each do |check|
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
      proc { check.execute! }
    end

    def callback(_check)
      proc do |packet|
        queue.publish(packet.to_json)
      end
    end

    def check_objects
      @checks.each_with_object([]) do |(name, options), acc|
        acc << Check.new(name: name, options: options)
      end
    end
  end
end
