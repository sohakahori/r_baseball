FactoryBot.define do
  factory :admin do
    sequence(:email) do |n|
      "test#{n}@email.com"
    end
    password { "testtest" }
  end
end
