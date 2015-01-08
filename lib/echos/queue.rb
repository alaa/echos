require 'bunny'
require 'forwardable'

module Echos
  module Queue
    class RabbitMQ
      extend Forwardable

      attr_reader :connection, :channel, :queue
      def_delegators :queue, :publish, :stop

      def initialize
        @connection ||= Bunny.new
        connection.start
        @channel ||= connection.create_channel
        @queue  ||= channel.queue('echos')
      end

      def consume(options = {})
        delivery_info, metadata, payload = queue.pop
        Echos.logger.info payload if payload
      end
    end
  end
end
