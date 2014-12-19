require 'optparse'

module Echos
  class OptionsParser

    def initialize
      @options = Hash.new
    end

    def parse(args=ARGV)
      parser = OptionParser.new do |option|
        config_option(option: option)
      end

      parser.parse!
      options
    end

    private
    attr_accessor :options

    def config_option(option:)
      option.on("-c", "-r --config", "Configurations File") do |file|
        options[:config] = file
      end
    end
  end
end

