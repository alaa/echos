require 'json'

module Echos
  class Packet

    def initialize(process)
      @process = process
    end

    def +(other)
      return false unless other.class == Hash
      body.merge!(other)
    end

    def to_json
      body.to_json
    end

    private
    attr_reader :process

    def body
      { process_stdout: process.out,
        process_stderr: process.err,
        process_exitstatus: process.status.exitstatus,
        process_runtime: process.runtime,
        process_pid: process.status.pid }
    end
  end

  class TimeoutPacket

    def body
      { process_runtime: -1 }
    end

    def +(other)
      return false unless other.class == Hash
      body.merge!(other)
    end

    def to_json
      body.to_json
    end

  end
end

