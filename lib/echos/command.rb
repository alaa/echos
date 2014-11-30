require 'posix/spawn'
require 'socket'
require 'json'

module Echos
  class Command

    DEFAULT_EXECUTION_TIMEOUT = 5

    def initialize
      @timeout = DEFAULT_EXECUTION_TIMEOUT
    end

    def execute!(check)
      @check = check
      command = check.path ? (check.path + check.command) : check.command

      begin
        @child = POSIX::Spawn::Child.new(command, timeout: (check.timeout || timeout))
        child.status.success?

      rescue POSIX::Spawn::TimeoutExceeded => e
        logger.error "Command #{check.command} timedout!"
        logger.error e
      end
    end

    def packet
      { hostname: Socket.gethostname,
        timestamp: Time.now,
        check_name: @check.name.to_s,
        check_handlers: @check.handlers,
        stdout: child.out,
        stderr: child.err,
        exitstatus: child.status.exitstatus,
        runtime: child.runtime,
        pid: child.status.pid }
    end

    private
    attr_reader :child, :check_name
  end
end

