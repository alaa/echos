require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require_relative('../lib/echos')

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
