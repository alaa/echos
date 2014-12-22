require 'spec_helper'

module Echos
  describe Check do

    let(:check_disk1) { Check.new(name: :check_disk1, command: "df -h") }
    let(:check_disk2) { Check.new(name: :check_disk2, command: "df -h") }
    let(:check_mem) { Check.new(name: :check_memory, command: "free -m") }

    it "understands equality" do
      expect(check_disk1 == check_disk2).to be_true
      expect(check_disk1 == check_mem).to be_false
      expect(check_disk1 == Object.new).to be_false
    end

    it "understands uniqueness" do
      expect([check_disk1, check_disk2].uniq.size).to eq 1
    end
  end
end

