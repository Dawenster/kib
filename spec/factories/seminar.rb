FactoryGirl.define do
  factory :seminar do
    trait :completed do
      completed { true }
    end
  end
end