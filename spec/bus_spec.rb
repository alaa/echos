require 'spec_helper'

module Echos
  describe Bus do

    before do
      @queue = double("queue")
      allow(Queue).to receive(:publish) { @queue }
      allow(Queue).to receive(:consume) { @queue }
      allow(Queue).to receive(:new) { @queue }
    end

    subject { Bus.new(Queue) }
    interfaces = [:publish, :consume]

    interfaces.each do |interface|
      it "responds to ##{interface}" do
        expect(subject).to respond_to interface
      end
    end

    it 'calls publish on Bus factory' do
      message = 'message'
      expect(@queue).to receive(:publish).with(message)
      subject.publish(message)
    end

    it 'calls consume on Bus factory' do
      expect(@queue).to receive(:consume)
      subject.consume
    end
  end
end
