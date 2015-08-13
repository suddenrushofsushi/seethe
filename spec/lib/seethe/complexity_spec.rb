RSpec.describe Seethe::Complexity do

  let(:complexity) { described_class.new("spec/fixtures/", 0) }
  describe "#process" do
    it "correctly flogs the example files" do
      expect(complexity.process).to eq({"spec/fixtures/example.erb"=>11.394735626595294, "spec/fixtures/example.rb"=>1.686689976405006})
    end
  end

  describe "#new_template" do
    it "returns a new action view template" do
      pending
      expect(complexity.send(:new_template), "Test body").to be_a ActionView::Template
    end
  end

  describe "#process_file" do
    it "returns a flog score for a given file" do
      expect(complexity.send(:process_file, "spec/fixtures/example.erb", {})).to eq 11.394735626595294
    end

    it "assigns the flog score to the second passed variable using the filename as the key" do
      totals = {}
      complexity.send(:process_file, "spec/fixtures/example.erb", totals)
      expect(totals["spec/fixtures/example.erb"]).to eq 11.394735626595294
    end

    it "catches and outputs any file read errors to console" do
      expect(STDOUT).to receive(:puts).with(/error parsing/i)
      complexity.send(:process_file, "notreallyafile", {})
    end
  end
end
