require 'json'
require 'multi_json'

module Echos
  class Loader

    def self.load_file(file)
      raise Exception unless valid_file?(file)

      content = IO.read(file)
      MultiJson.load(content, symbolize_keys: true)

    rescue MultiJson::ParseError => exception
      Echos::logger.info(exception.cause)
    end

    private

    def self.valid_file?(file)
      File.file?(file) && File.readable?(file)
    end

  end
end

