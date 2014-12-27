require 'spec_helper'

module Echos
  describe Bus do
    subject{ Bus.new(Class) }

    interfaces = [:publish, :consume]

    interfaces.each do |interface|
      it "responds to ##{interface}" do
        expect(subject).to respond_to interface
      end
    end
  end
end

