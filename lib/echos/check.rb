module Echos
  class Check

    DEFAULT_CHECK_TIMEOUT = 1
    DEFFAULT_INTERVAL_VALUE = 5
    DEFAULT_HANDLER = "default_handler"

    attr_reader :interval

    def initialize(name:,
                   command:,
                   timeout: DEFAULT_CHECK_TIMEOUT,
                   handlers: DEFAULT_HANDLER,
                   path: false,
                   interval: DEFFAULT_INTERVAL_VALUE)
      @name = name
      @command = command
      @timeout = timeout
      @handlers = handlers
      @path = path
      @interval = interval
    end

    def execute!
      command = Command.new(command: command_with_path, timeout: timeout)
      packet = command.execute!
      packet + check_data
    end

    def ==(other)
      return false unless self.class === other
      self.command_with_path == other.command_with_path
    end
    alias_method :eql?, :==

    protected
    attr_reader :name, :command, :timeout, :handlers, :path

    def check_data
      {check_name: name,
       command: command_with_path,
       timeout: timeout,
       handlers: handlers,
       interval: interval,
       timestamp: Time.now}
    end

    def hash
      self.command_with_path.hash
    end

    def command_with_path
      path ? File.join(path, command) : command
    end
  end
end

