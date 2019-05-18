require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:campaign) {create :campaign}

  describe "validations" do
    it "has a valid factory" do
      expect(campaign).to be_valid
    end
    it "require a network" do
      expect(build :campaign, network_criteria: nil).not_to be_valid
    end
  end

  describe ".matching" do
    let!(:match_name_campaign) {create :campaign, network_criteria: "youtube"}
    let!(:match_count_campaign) {create :campaign, views_criteria: 500}
    let!(:match_like_campaign) {create :campaign, likes_criteria: 400}
    let!(:match_subs_campaign) {create :campaign, subscribers_criteria: 600}
    let!(:match_age_campaign) {create :campaign, min_age_criteria: 20, max_age_criteria:30}
    let!(:match_country_campaign) {create :campaign, country_criteria: "france"}
    let!(:view_name_campaign) {create :campaign, network_criteria: "youtube", views_criteria: 500}
    let!(:like_name_campaign) {create :campaign, network_criteria: "youtube", likes_criteria: 400}
    let!(:subs_name_campaign) {create :campaign, network_criteria: "youtube", subscribers_criteria: 600}
    let!(:country_name_campaign) {create :campaign, network_criteria: "youtube", country_criteria: "france"}
    let!(:campaign_deny1) do
      create :campaign, network_criteria: "youtube", likes_criteria:400, views_criteria: 500, subscribers_criteria: 600
    end
    let!(:campaign_deny2) do
      create :campaign, network_criteria: "youtube", likes_criteria:400, views_criteria: 500
    end
    let!(:campaign_deny3) do
      create :campaign, network_criteria: "youtube", likes_criteria:400, views_criteria: 500, subscribers_criteria: 600,
                        country_criteria: "france"
    end
    let!(:network) do
      create :network, name: "youtube", likes_count: 400, views_count: 500, subscribers_count: 600
    end
    let!(:matching_campaign) do
      create :campaign, network_criteria: "youtube", likes_criteria: 400, views_criteria: 500, subscribers_criteria: 600,
                        country_criteria: "france", min_age_criteria: 20, max_age_criteria: 30
    end
    let!(:user) {create :user, dob: 25.years.ago}
    let!(:campaign) {create :campaign}
    let(:on_test) {Campaign.matching(network, user)}

    it "return a relation" do
      expect(on_test).to be_an ActiveRecord::Relation
    end
    it "return correct size relation" do
      expect(on_test.size).to eq 1
    end
    it "return the matching campaign" do
      expect(on_test).to include matching_campaign
    end
  end

  describe ".per_network" do
    let(:on_test) {Campaign.per_network("youtube")}
    let(:matching_campaign) {create :campaign, network_criteria: "youtube"}
    let(:campaign) {create :campaign}

    context "with no campaign" do
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a non-matching campaign" do
      before { campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a matching campaign" do
      before { matching_campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
    context "with matching and non-matching campaign" do
      before { matching_campaign ; campaign}
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
  end

  describe ".views_less_than" do
    let(:on_test) {Campaign.views_less_than(500)}
    let(:matching_campaign) {create :campaign, views_criteria: 500}
    let(:campaign) {create :campaign, views_criteria: 501}

    context "with no campaign" do
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a non-matching campaign" do
      before { campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a matching campaign" do
      before { matching_campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
    context "with matching and non-matching campaign" do
      before { matching_campaign ; campaign}
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
  end

  describe ".likes_less_than" do
    let(:on_test) {Campaign.likes_less_than(500)}
    let(:matching_campaign) {create :campaign, likes_criteria: 500}
    let(:campaign) {create :campaign, likes_criteria: 501}

    context "with no campaign" do
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a non-matching campaign" do
      before { campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a matching campaign" do
      before { matching_campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
    context "with matching and non-matching campaign" do
      before { matching_campaign ; campaign}
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
  end

  describe ".subscribers_less_than" do
    let(:on_test) {Campaign.subscribers_less_than(500)}
    let(:matching_campaign) {create :campaign, subscribers_criteria: 500}
    let(:campaign) {create :campaign, subscribers_criteria: 501}

    context "with no campaign" do
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a non-matching campaign" do
      before { campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a matching campaign" do
      before { matching_campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
    context "with matching and non-matching campaign" do
      before { matching_campaign ; campaign}
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
  end

  describe ".per_country" do
    let(:on_test) {Campaign.per_country("italy")}
    let(:matching_campaign) {create :campaign, country_criteria: "italy"}
    let(:campaign) {create :campaign}

    context "with no campaign" do
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a non-matching campaign" do
      before { campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a matching campaign" do
      before { matching_campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
    context "with matching and non-matching campaign" do
      before { matching_campaign ; campaign}
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
  end

  describe ".age_include" do
    let(:on_test) {Campaign.age_include(50)}
    let(:matching_campaign) {create :campaign, min_age_criteria: 40, max_age_criteria: 50}
    let(:campaign) {create :campaign, min_age_criteria: 40, max_age_criteria: 49}

    context "with no campaign" do
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a non-matching campaign" do
      before { campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return an empty relation" do
        expect(on_test.size).to eq 0
      end
    end
    context "with a matching campaign" do
      before { matching_campaign }
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
    context "with matching and non-matching campaign" do
      before { matching_campaign ; campaign}
      it "return an ActiveRecord relation" do
        expect(on_test).to be_an ActiveRecord::Relation
      end
      it "return a size 1 relation" do
        expect(on_test.size).to eq 1
      end
      it "include correct campaign" do
        expect(on_test).to include matching_campaign
      end
    end
  end
end
