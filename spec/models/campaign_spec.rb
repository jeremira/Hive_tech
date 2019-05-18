require 'rails_helper'

RSpec.describe Campaign, type: :model do
  let(:campaign) {create :campaign}

  describe "validations" do
    it "has a valid factory" do
      expect(campaign).to be_valid
    end
  end
end
