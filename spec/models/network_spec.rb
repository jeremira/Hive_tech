require 'rails_helper'

RSpec.describe Network, type: :model do
  let(:network) {create :network}

  describe "validations" do
    it "has a valid factory" do
      expect(network).to be_valid
    end
    #The views column must be always nil for Instagram, because Instagram has no views metrics.
  end
end
