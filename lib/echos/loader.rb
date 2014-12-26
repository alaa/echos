require 'yaml'

module Echos
  class Loader

    def self.load_file(file)
      raise Exception unless valid_file?(file)
      YAML.load_file(file)
    end

    private

    def self.valid_file?(file)
      File.file?(file) && File.readable?(file)
    end

  end
end

