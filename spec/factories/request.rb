FactoryGirl.define do
  factory :request do
    trait :assigned do
      assigned { true }
    end
  end
end