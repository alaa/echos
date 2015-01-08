require 'json'

module Echos
  module BasePacket
    def +(other)
      fail TypeError unless other.class == Hash
      body.merge!(other)
    end

    def to_json
      body.to_json
    end

    def body
      {}
    end
  end

  Packet = Struct.new(:process) do
    include BasePacket

    private

    def body
      {
        process_stdout: process.out,
        process_stderr: process.err,
        process_exitstatus: process.status.exitstatus,
        process_runtime: process.runtime,
        process_pid: process.status.pid
      }
    end
  end

  TimeoutPacket = Struct.new(:process) do
    include BasePacket

    private

    def body
      { process_runtime: -1 }
    end
  end
end
