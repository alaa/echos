require 'posix/spawn'
require 'json'

module Echos
  class Command

    def initialize(command:, timeout:)
      @command, @timeout = command, timeout
    end

    def execute!
      begin
        @process = POSIX::Spawn::Child.new(command, timeout: timeout)
        completed_command

      rescue POSIX::Spawn::TimeoutExceeded => e
        Echos::logger.error e
        not_completed_command
      end
    end

    private
    attr_accessor :command, :timeout, :process

    def completed_command
      { process_stdout: process.out,
        process_stderr: process.err,
        process_exitstatus: process.status.exitstatus,
        process_runtime: process.runtime,
        process_pid: process.status.pid }
    end

    def not_completed_command
      { process_runtime: -1 }
    end

  end
end
