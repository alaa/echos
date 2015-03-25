require 'spec_helper'
require 'ostruct'
require 'json'

module Echos
  describe BasePacket do

    let(:dummy) do
      Class.new do
        include BasePacket
      end
    end

    it 'expects packet class to understand addition with hash' do
      expect { dummy.new + Hash.new }.not_to raise_error
    end

    it 'responds to body' do
      expect(dummy.new).to respond_to(:body)
    end
  end

  describe Packet do
    let (:status) do
      OpenStruct.new(exitstatus: 0,
                     pid: 23_456)
    end

    let(:process) do
      OpenStruct.new(out: 'stdout',
                     err: 'stderr',
                     runtime: '0.65',
                     status: status)
    end

    let(:packet) do
      {
        process_stdout: process.out,
        process_stderr: process.err,
        process_exitstatus: process.status.exitstatus,
        process_runtime: process.runtime,
        process_pid: process.status.pid
      }
    end

    subject { Packet.new(process) }

    it 'converts process data structure to json' do
      allow(SecureRandom).to receive(:uuid).and_return('uuid')
      expect(subject.body).to include({uuid: 'uuid'}.merge! packet)
    end
  end

  describe TimeoutPacket do
    it 'returns proper body of the timeout packet' do
      allow(SecureRandom).to receive(:uuid).and_return('uuid')
      timeoutpacket = described_class.new
      expect(timeoutpacket.body).to include({ uuid: 'uuid', process_runtime: -1 })
    end
  end
end
