FactoryGirl.define do
  factory :course do
    code   { "#{Faker::Lorem.characters(4).upcase}-#{rand(10 ** 3)}-0" }
    name   { Faker::Name.title }
    active { true }
  end
end