require 'yaml'

module Echos
  class Loader
    def self.load_file(file)
      raise InvalidFile unless valid_file?(file)
      YAML.load_file(file)
    end

    def self.valid_file?(file)
      File.file?(file) && File.readable?(file)
    end
  end
end
