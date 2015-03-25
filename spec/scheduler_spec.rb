require 'spec_helper'

module Echos
  describe Scheduler do
    let(:check1) {
      [ name: 'check1',
        options: { command: 'dummyCommand' } ]
    }

    let(:check2) {
      [ name: 'check2',
        options: { command: 'dummyCommand2' } ]
    }

    let(:bus) { Class }

    subject { Scheduler.new(check1 + check2, bus) }

    it 'responds to execute' do
      expect(subject).to respond_to(:start!)
    end

    it "calls EventMachine" do
      expect(EM).to receive(:run)
      subject.start!
    end
  end
end
