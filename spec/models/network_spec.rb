require 'rails_helper'

RSpec.describe Network, type: :model do
  let(:network) {create :network}

  describe "validations" do
    it "has a valid factory" do
      expect(network).to be_valid
    end
    context "with Instagram" do
      it "dont accept null view count" do
        expect(build :network, name: :instagram, views_count: 0).not_to be_valid
      end
      it "dont accept view count" do
        expect(build :network, name: :instagram, views_count: 1).not_to be_valid
      end
      it "require nil views count" do
        expect(build :network, name: :instagram, views_count: nil).to be_valid
      end
    end
  end
end
