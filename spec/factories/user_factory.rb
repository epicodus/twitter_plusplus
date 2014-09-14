FactoryGirl.define do
  factory :user do
    sequence(:email)    { |num| "user#{num}@twitterpp.com"  }
    sequence(:handle)   { |num| "handle#{num}"              }
    sequence(:password) { |num| "password#{num}"            }
  end
end
