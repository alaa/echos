class Template
  attr_reader :name, :checks

  def initialize(name)
    @name = name
    @checks ||= []
  end

  def add(checks)
    return false if checks.any? { |c| c.class != Check }

    checks_dup = checks.dup.uniq
    @checks.concat(checks_dup)
  end

  def +(other)
    raise TypeError if other.class != Template
    return self if self == other

    self.name = [self.name, other.name].map!(&:to_s).join('_and_')
    self.checks = (self.checks << other.checks).flatten.uniq
    self
  end

  def ==(other)
    return false unless self.class === other
    self.name == other.name && self.checks == other.checks
  end

  private
  attr_writer :name, :checks
end

