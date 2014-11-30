require 'socket'

module Echos
  class Packet

    def initialize(check, proccess)
      @check = check
      @proccess = proccess
    end

    def success
      base_packet.merge(
        { stdout: proccess.out,
          stderr: proccess.err,
          exitstatus: proccess.status.exitstatus,
          runtime: proccess.runtime,
          pid: proccess.status.pid })
    end

    def timeout
      base_packet.merge(
        { stdout: "timeout",
          stderr: "timeout" })
    end

    def hostname
      Socket.gethostname
    end

    def ipaddress
      "1.1.1.1"
    end

    private
    attr_reader :check, :proccess

    def base_packet
      { hostname: hostname,
        ipaddress: ipaddress,
        timestamp: Time.now,
        check_name: check.name.to_s,
        check_handlers: check.handlers }
    end
  end
end

