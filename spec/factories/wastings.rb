FactoryBot.define do
  factory :wasting do
    name { "お菓子" }
    price { 200 }
    association :user
  end
end
