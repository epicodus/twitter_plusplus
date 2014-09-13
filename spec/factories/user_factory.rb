FactoryGirl.define do
  factory :user do
    email "justin@test.com"
    handle "justin"
    bio "This is a dummy account for test purposes"
    password "password"
  end
end
