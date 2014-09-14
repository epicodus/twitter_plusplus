FactoryGirl.define do
  factory :tweet do
    sequence(:content) { |num| "This is test tweet number #{num} " }
  end
end
