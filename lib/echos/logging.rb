require 'logger'

module Echos
  module Logging

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def logger
        @logger ||= Logger.new($stdout)
      end
    end

    def logger
      Logging.logger
    end

  end
end
