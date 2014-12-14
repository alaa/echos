require 'eventmachine'
require 'json'

module Echos
  class Client

    def initialize(checks, queue)
      @checks, @queue = checks, queue
    end

    def start!
      EM.run do
        checks.each do |check|
          check_obj = Check.new(check.last.merge(name: check.first))
          puts check_obj.interval

          EM.add_periodic_timer(check_obj.interval) do
            EM.defer(operation(check_obj), callback(check_obj))
          end

        end
      end
    end

    private
    attr_reader :checks, :queue

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

