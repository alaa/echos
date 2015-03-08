module Echos
  class Check
    DEFAULT_CHECK_TIMEOUT = 1
    DEFFAULT_INTERVAL_VALUE = 5
    DEFAULT_HANDLER = 'default_handler'

    attr_reader :interval

    def initialize(name:, options: options)
      @name = name
      @command = options['command']
      @timeout = options.fetch('timeout', DEFAULT_CHECK_TIMEOUT)
      @handlers = options.fetch('handlers', DEFAULT_HANDLER)
      @path = options.fetch('path', false)
      @interval = options.fetch('interval', DEFFAULT_INTERVAL_VALUE)
    end

    def execute!
      cmd = Command.new(command: command_with_path, timeout: timeout)
      packet = cmd.execute!
      packet + check_data
    end

    def ==(other)
      return false unless self.class == other.class
      command_with_path == other.command_with_path
    end
    alias_method :eql?, :==

    protected

    attr_reader :name, :command, :timeout, :handlers, :path

    def check_data
      {
        check_name: name,
        command: command_with_path,
        timeout: timeout,
        handlers: handlers,
        interval: interval,
        timestamp: Time.now
      }
    end

    def hash
      command_with_path.hash
    end

    def command_with_path
      path ? full_path : command
    end

    def full_path
      raise(InvalidPath, @name) unless File.directory?(path)
      File.join(path, command)
    end
  end

  class InvalidPath < Exception; end
end
