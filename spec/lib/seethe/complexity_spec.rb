RSpec.describe Seethe::Complexity do
  describe "#process" do
    it "correctly flogs the example files" do
      expect(described_class.new("spec/fixtures/", 0).process).to eq({"spec/fixtures/example.erb"=>11.394735626595294, "spec/fixtures/example.rb"=>1.686689976405006})
    end
  end
end
