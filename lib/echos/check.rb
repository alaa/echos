module Echos
  # Understands how to read a config file. and to give check
  # The class is the config the data is an Array of Strucuts

  class Check
    # consider converting this into a Strucut

    attr_reader :name, :timeout, :handlers, :path, :interval

    DEFAULT_CHECK_TIMEOUT = 1
    DEFFAULT_INTERVAL_VALUE = 10
    DEFAULT_HANDLER = "default_handler"

    def initialize( name:,
                    command:,
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

    def command
      path ? (path + @command) : @command
    end

  end
end

