require 'bunny'
require 'json'
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
        msg = JSON.parse payload
        Echos.logger.info msg if payload
      rescue
      end
    end
  end
end
