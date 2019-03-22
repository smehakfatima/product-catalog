FactoryGirl.define do
  factory :product do
    name 'a' * 20
    description 'a' * 20
    user
    category
  end
end
