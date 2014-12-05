require 'posix/spawn'
require 'json'

module Echos
  class Command
    DEFAULT_EXECUTION_TIMEOUT = 5

    def initialize(args={})
      @timeout = args.fetch(:timeout, DEFAULT_EXECUTION_TIMEOUT)
    end

    def execute!(check)
      @check = check
      command = check.path ? (check.path + check.command) : check.command

      begin
        @child = POSIX::Spawn::Child.new(command, timeout: (check.timeout || timeout))
        success?

      rescue POSIX::Spawn::TimeoutExceeded => e
        Echos::logger.error "Command #{check.command} timedout!"
        Echos::logger.error e
      end
    end

    def packet
      packet = Echos::Packet.new(check, child)
      success? ? packet.success : packet.timeout
    end

    private
    attr_reader :timeout, :child, :check

    def success?
      begin
        child.status.success?
      rescue
        false
      end
    end
  end
end

