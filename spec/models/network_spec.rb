require 'rails_helper'

RSpec.describe Network, type: :model do
  let(:network) {create :network}

  describe "validations" do
    it "has a valid factory" do
      expect(network).to be_valid
    end
  end
end
