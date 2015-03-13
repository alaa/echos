$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'echos/logging'
require 'echos/loader'
require 'echos/check'
require 'echos/command'
require 'echos/queue'
require 'echos/bus'
require 'echos/packet'
require 'echos/scheduler'
require 'echos/cli'

module Echos
  include Logging

  class Version
    VERSION = '0.1'

    def self.to_s
      "Running Echos version #{VERSION}"
    end
  end
end
