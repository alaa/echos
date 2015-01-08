module Echos
  class Bus
    def initialize(queue)
      @bus = queue.new
    end

    def publish(message)
      @bus.publish(message)
    end

    def consume(options = {})
      @bus.consume(options)
    end
  end
end
