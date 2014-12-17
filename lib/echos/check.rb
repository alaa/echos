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
      execute_object = Command.new(command: command_with_path, timeout: timeout)
      process_info = execute_object.execute!
      merge_check_info(process_info)
    end

    private
    attr_reader :name, :command, :timeout, :handlers, :path

    def ==(other)
      return false unless self.class === other
      self.name == other.name && self.command_with_path == other.command_with_path
    end

    def hash
      [self.name, self.command].hash
    end

    def command_with_path
      path ? (path + command) : command
    end

    def merge_check_info(hash)
      hash.merge(check_name: name,
                 command: command_with_path,
                 timeout: timeout,
                 handlers: handlers,
                 interval: interval,
                 timestamp: Time.now)
    end
  end
end

