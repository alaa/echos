module Echos
  class Check
    attr_reader :name, :command, :timeout, :handlers, :path, :interval

    DEFAULT_CHECK_TIMEOUT = 5
    DEFFAULT_INTERVAL_VALUE = 5
    DEFAULT_HANDLER = "default_handler"

    def initialize( name:, command:,
                    timeout: DEFAULT_CHECK_TIMEOUT,
                    handlers: DEFAULT_HANDLER,
                    path: false,
                    interval: DEFFAULT_INTERVAL_VALUE )
      @name = name
      @command = command
      @timeout = timeout
      @handlers = handlers
      @path = path
      @interval = interval
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

