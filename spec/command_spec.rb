require 'spec_helper'

module Echos
  describe Command do
    subject { Command.new(command: 'ls', timeout: 1) }

    it "responds to execute" do
      expect(subject).to respond_to(:execute!)
    end

    it "returns packet upon command execution" do
      expect(subject.execute!).to be_kind_of(Packet)
    end

    context "execution timeout" do
      subject { Command.new(command: 'sleep 2', timeout: 1) }

      it "raises exception on execution timeout" do
        expect(subject.execute!).to be_kind_of(TimeoutPacket)
      end
    end
  end
end

