RSpec.describe Seethe::Churn do

  describe "#process" do
    it "correctly sees churn in the repo" do
      churn = described_class.new("spec/fixtures", 0).process
      expect(churn["spec/fixtures/example.rb"].to_i).to be > 0
    end
  end

end

