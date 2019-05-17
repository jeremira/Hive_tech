FactoryGirl.define do
  factory :user do
    sequence :name {|n| "name_#{n}"}
    sequence :email {|n| "email_#{n}@test.com"}
    password "please123"
  end
end
