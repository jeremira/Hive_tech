require "rails_helper"

RSpec.describe "Store", type: :request do
  let(:user) { create :user }
  before { sign_in user }

  describe "GET index" do
    let!(:campaign1) { create :campaign, network_criteria: "youtube", subscribers_criteria: 5000 }
    let!(:campaign2) { create :campaign, network_criteria: "youtube", subscribers_criteria: 10000}
    let!(:campaign3) { create :campaign, network_criteria: "instagram" }
    let!(:network1)  { create :network, user: user, name: "instagram" }
    let!(:network2)  { create :network, user: user, name: "youtube", subscribers_count: 7000 }

    before do
      get stores_path
    end

    it "return a json" do
      expect(response.body).to be_an String
    end
    it "return a collection" do
      expect(JSON.parse(response.body)).to be_an Array
    end
    it "return 2 campaign" do
      expect(JSON.parse(response.body).size).to eq 2
    end
    it "include campaign 1" do
      expect(JSON.parse(response.body).find {|campaign| campaign["id"] == campaign1.id}).to be_an Hash
    end
    it "include campaign 3" do
      expect(JSON.parse(response.body).find {|campaign| campaign["id"] == campaign3.id}).to be_an Hash
    end
  end
end
