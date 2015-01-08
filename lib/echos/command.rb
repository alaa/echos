require 'posix/spawn'

module Echos
  class Command
    def initialize(command:, timeout:)
      @command, @timeout = command, timeout
    end

    def execute!
      process = POSIX::Spawn::Child.new(command, timeout: timeout)
      Packet.new(process)

    rescue POSIX::Spawn::TimeoutExceeded
      TimeoutPacket.new
    end

    private

    attr_accessor :command, :timeout
  end
end
