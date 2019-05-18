FactoryGirl.define do
  factory :user do
    sequence :name {|n| "name_#{n}"}
    sequence :email {|n| "email_#{n}@test.com"}
    country {"france"}
    dob {"Mon, 01 Jan 2000 00:00:00 +0000"}
    password "please123"
  end
end
