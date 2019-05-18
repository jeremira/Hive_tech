FactoryGirl.define do
  factory :user do
    sequence :name {|n| "name_#{n}"}
    sequence :email {|n| "email_#{n}@test.com"}
    country {"france"}
    dob {"1983-01-28 00:00:00"}
    password "please123"
  end
end
