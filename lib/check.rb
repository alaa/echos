class Check
  attr_reader :name, :command

  def initialize(args)
    @name = args[:name]
    @command = args[:command]
  end

  def ==(other)
    return false unless self.class === other
    self.name == other.name && self.command == other.command
  end

  def hash
    [self.name, self.command].hash
  end
end

