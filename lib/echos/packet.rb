require 'socket'

module Echos
  class Packet

    # make them private
    attr_reader :name, :handlers, :proccess

    def initialize(name, handlers, proccess)
      @name = name
      @handlers = handlers
      @proccess = proccess
    end

    def success
      base_packet.merge(
        stdout: proccess.out,
        stderr: proccess.err,
        exitstatus: proccess.status.exitstatus,
        runtime: proccess.runtime,
        pid: proccess.status.pid
      )
    end

    def timeout
      base_packet.merge(
        stdout: "timeout",
        stderr: "timeout"
      )
    end

    def hostname
      Socket.gethostname
    end

    def ipaddress
      "1.1.1.1"
    end

    private

    def base_packet
      {
        hostname: hostname,
        ipaddress: ipaddress,
        timestamp: Time.now,
        name: name,
        handler: handlers
      }
    end
  end
end

