require 'spec_helper'

module Echos
  describe Check do

    let(:check_disk1) { Check.new(name: 'check_disk1',
                                  options: {'command' => 'df -h'} ) }

    let(:check_disk2) { Check.new(name: 'check_disk2',
                                  options: {'command' => 'df -h'} ) }

    let(:check_mem) { Check.new(name: 'check_memory',
                                options: {'command' => 'free -m'} ) }

    describe "#==" do
      it "should be equal to similar check" do
        expect(check_disk1).to eq check_disk2
      end

      it "should not be equal with different command" do
        expect(check_disk1).to_not eq check_mem
      end

      it "returns false with equality with different object type" do
        expect(check_disk1).to_not eq Object.new
      end
    end

    it "understands uniqueness" do
      expect([check_disk1, check_disk2].uniq.size).to eq 1
    end
  end
end

