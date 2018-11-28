FactoryBot.define do
  factory :response do
    sequence(:body) do |n|
      "コメント_#{n}"
    end
    association :user
    association :board
  end
end
