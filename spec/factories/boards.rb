FactoryBot.define do
  factory :board do
    sequence :title do |n|
      "title#{n}"
    end
    association :user
  end
end
