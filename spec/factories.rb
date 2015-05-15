FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }

    password "foobarzz"

    sequence(:firstname) { |n| "foo#{n}" }

    sequence(:lastname) { |n| "bar#{n}" }

    dob { 18.years.ago }
  end
end