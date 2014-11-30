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
      command = (check.path + check.command) || check.command
      begin
        child = POSIX::Spawn::Child.new(command, timeout: (check.timeout || timeout))

        @pid = child.status.pid
        @stdout = child.out
        @stderr = child.err
        @exitstatus  = child.status.exitstatus
        @runtime = child.runtime
        @check_name = check.name.to_s

        child.status.success?

      rescue POSIX::Spawn::TimeoutExceeded => e
        logger.error "Command #{check.command} timedout!"
        logger.error e
      end
    end

    def packet
      { hostname: Socket.gethostname,
        timestamp: Time.now,
        check_name: @check_name,
        stdout: @stdout,
        stderr: @stderr,
        exitstatus: @exitstatus,
        runtime: @runtime,
        pid: @pid }
    end
  end
end
