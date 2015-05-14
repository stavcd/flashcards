FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end
  factory :user do
    email
    password '12345'
    password_confirmation '12345'
  end
end

