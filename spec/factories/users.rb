FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:line_id) { |n| "line_id#{n}" }
  end
end
