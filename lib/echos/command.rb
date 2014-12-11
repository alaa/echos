require 'posix/spawn'
require 'json'

module Echos
  class Command

    attr_reader :name, :command, :timeout, :child, :handlers
    # make readers private

    def initialize(name, command, handlers, timeout)
      @name, @command, @hanlders, @timeout = name, command, handlers, timeout
    end

    def execute!
      begin
        puts command
        @child = POSIX::Spawn::Child.new(command, timeout.to_s)
        success?

      rescue POSIX::Spawn::TimeoutExceeded => e
        Echos::logger.error "Command #{command} timedout!"
        Echos::logger.error e
      end
    end

    def packet
      packet = Echos::Packet.new(name, handlers, child)
      success? ? packet.success : packet.timeout
    end

    private

    def success?
      begin
        child.status.success?
      rescue
        false
      end
    end
  end
end

