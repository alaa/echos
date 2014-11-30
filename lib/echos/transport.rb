require "bunny"

module Echos
  class Transport

    def initialize
      @conn = Bunny.new
      @conn.start
      @ch = @conn.create_channel
      @queue  = @ch.queue("echos")
    end

    def publish(msg)
      @queue.publish(msg)
    end

    def consume(options = {})
      delivery_info, metadata, payload = @queue.pop
      debug_mode = options.fetch(:debug, false)

      if debug_mode
        Echos::logger.info delivery_info
        Echos::logger.info puts metadata
      end

      Echos::logger.info puts payload
    end

    def stop
      @conn.stop
    end

  end
end

