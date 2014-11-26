require_relative "../lib/check"

describe Check do
  let(:check_disk) { Check.new(name: :check_disk, command: "df -h") }
  let(:check_mem) { Check.new(name: :check_memory, command: "free -m") }

  it "adds checks" do
    expect(check_disk.name).to eql :check_disk
    expect(check_disk.command).to eql "df -h"
  end

  it "understand equality" do
    expect(check_disk == check_disk).to be_true
    expect(check_disk == check_mem).to be_false
    expect(check_disk == Object.new).to be_false
  end

  it "understand uniqueness" do
    expect([check_disk, check_disk, check_mem].uniq.size).to eq 2
  end
end

