require 'logger'

module Logging

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def logger
      @logger ||= Logger.new($stdout)
    end
  end

  # Instance methods
  def logger
    Logging.logger
  end

end

