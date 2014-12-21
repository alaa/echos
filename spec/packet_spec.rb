require 'spec_helper'
require 'ostruct'
require 'json'

module Echos
  describe BasePacket do

    let(:dummy) {
      Class.new do
        include BasePacket
      end
    }

    it "expects packet class to understand addition with hash" do
      expect{ dummy.new + Hash.new }.not_to raise_error
    end

    it "expects packet to respond to to_json" do
      expect(dummy.new).to respond_to(:to_json)
    end
  end

  describe Packet do
    let (:status) { OpenStruct.new(:exitstatus => 0,
                                   :pid => 23456) }

    let(:process) { OpenStruct.new(:out => "stdout",
                                   :err => "stderr",
                                   :runtime => "0.65",
                                   :status => status) }

    let(:json_packet) {
      { process_stdout: process.out,
        process_stderr: process.err,
        process_exitstatus: process.status.exitstatus,
        process_runtime: process.runtime,
        process_pid: process.status.pid }.to_json
    }

    subject { Packet.new(process) }

    it "converts process data structure to json" do
      expect(subject.to_json).to eql json_packet
    end
  end

  describe TimeoutPacket do
    it "returns proper body of the timeout packet" do
      timeoutpacket = described_class.new
      expect(timeoutpacket.to_json).to eql ({ process_runtime: -1 }.to_json)
    end
  end
end
