require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create :user}

  describe "validations" do
    it "has a valid factory" do
      expect(user).to be_valid
    end
    it "require a country" do
      expect(build :user, country: nil).not_to be_valid
    end
    it "require a date of birth" do
      expect(build :user, dob: nil).not_to be_valid
    end
  end

  describe "#age" do
    let(:baby) {create :user, dob: Time.zone.now}
    let(:me) {create :user, dob: Time.zone.parse("1983-01-28 00:00:00")}
    let(:napoleon) {create :user, dob: Time.zone.parse("1769-08-15 00:00:00")}
    it "handle newbord baby" do
      expect(baby.age).to eq 0
    end
    it "handle my extremely important personal case" do
      expect(me.age).to eq 36
    end
    it "handle napoleon" do
      expect(napoleon.age).to eq 249
    end
  end
end
