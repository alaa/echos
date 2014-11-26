require_relative "../lib/template"

describe Template do
  let(:check_disk) { Check.new(name: :check_disk, command: "df -h") }
  let(:check_mem) { Check.new(name: :check_memory, command: "free -m") }

  it "initializes with a name" do
    template = Template.new(:basic)
    expect(template.name).to eq :basic
  end

  context "Add checks" do
    it "adds check objects" do
      template = Template.new(:basic)

      template.add([check_disk, check_disk, check_mem])
      expect(template.checks.count).to eq 2
    end

    it "raises TypeError if checks array is not a Check Object" do
      template = Template.new(:basic)
      expect(template.add([Object.new])).to be_false
    end
  end

  context "Add templates to each other" do
    it "can sum templates together" do
      template1 = Template.new(:basic1)
      template1.add([check_disk])

      template2 = Template.new(:basic2)
      template2.add([check_mem])

      template_1_2 = template1 + template2
      expect(template_1_2.name).to eq "basic1_basic2"
      expect(template_1_2.checks).to eq [check_disk, check_mem]
    end

    it "does not sum itself" do
      template1 = Template.new(:basic1)
      template1.add([check_disk])
      template_1_1 = template1 + template1

      expect(template_1_1.name).to eq :basic1
      expect(template_1_1.checks).to eq [check_disk]
      expect{ template1 + Object.new }.to raise_error
    end
  end
end

