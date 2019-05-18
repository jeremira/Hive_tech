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
    let(:network) {create :network, name: "youtube", likes_count: 400, views_count: 500, subscribers_count: 600}
    let(:match_name_campaign) {create :campaign, network_criteria: "youtube"}
    let(:match_count_campaign) {create :campaign, views_criteria: 500}
    let(:match_like_campaign) {create :campaign, likes_criteria: 400}
    let(:match_subs_campaign) {create :campaign, subscribers_criteria: 600}
    let(:view_name_campaign) {create :campaign, network_criteria: "youtube", views_criteria: 500}
    let(:like_name_campaign) {create :campaign, network_criteria: "youtube", likes_criteria: 400}
    let(:subs_name_campaign) {create :campaign, network_criteria: "youtube", subscribers_criteria: 600}
    let(:matching_campaign) do
      create :campaign, network_criteria: "youtube", likes_criteria:400, views_criteria: 500, subscribers_criteria: 600
    end
    let(:campaign) {create :campaign}
    let(:on_test) {Campaign.matching(network)}

    before do
      match_like_campaign ; match_name_campaign ; match_count_campaign ; view_name_campaign
      match_subs_campaign ; subs_name_campaign
      network ; campaign ; matching_campaign
    end

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

  describe ".network_name" do
    let(:on_test) {Campaign.network_name("youtube")}
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
end
