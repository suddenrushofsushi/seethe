RSpec.describe Seethe do

  describe ".complect" do
    it "combines complexity and churn" do
      complected = Seethe.complect("spec/fixtures", 0, 0)
      hash = complected["spec/fixtures/example.erb"]
      expect(hash[:churn].to_i).to be > 0
      expect(hash[:complexity].to_f).to be > 11
    end
  end

  describe ".glob_directory" do
    it "globs like a boss" do
      expect(described_class.glob_directory("spec/fixtures")).to include("spec/fixtures/example.rb")
    end
  end

  describe "preparation" do
    it "changes directory appropriately" do
      expect(Dir.pwd).to eq(File.expand_path("."))
    end
  end

end
