module Echos
  class Check
    attr_reader :name, :command, :timeout, :handlers, :path

    DEFAULT_CHECK_TIMEOUT = 5
    DEFAULT_HANDLER = "default_handler"

    def initialize(check_name, args={})
      @name = check_name
      @command = args[:command]
      @timeout = args.fetch(:timeout, DEFAULT_CHECK_TIMEOUT)
      @handlers = args.fetch(:handlers, DEFAULT_HANDLER)
      @path = args.fetch(:path, false)
    end

    def ==(other)
      return false unless self.class === other
      self.name == other.name && self.command == other.command
    end

    def hash
      [self.name, self.command].hash
    end
  end
end

