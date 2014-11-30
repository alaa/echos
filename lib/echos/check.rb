module Echos
  class Check
    attr_reader :name, :command, :timeout, :handlers, :path, :interval

    DEFAULT_CHECK_TIMEOUT = 5
    DEFFAULT_INTERVAL_VALUE = 30
    DEFAULT_HANDLER = "default_handler"

    def initialize(check_name, args={})
      @name = check_name
      @command = args[:command]
      @timeout = args.fetch(:timeout, DEFAULT_CHECK_TIMEOUT)
      @handlers = args.fetch(:handlers, DEFAULT_HANDLER)
      @path = args.fetch(:path, false)
      @interval = args.fetch(:interval, DEFFAULT_INTERVAL_VALUE)
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

