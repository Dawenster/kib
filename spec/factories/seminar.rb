FactoryGirl.define do
  factory :seminar do
    trait :complete do
      complete { true }
    end
  end
end