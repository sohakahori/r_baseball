FactoryBot.define do
  factory :admin do
    sequence(:email) do |n|
      "test#{n}@email.com"
    end
    sequence(:first_name) do |n|
      "名#{n}"
    end
    sequence(:last_name) do |n|
      "苗字#{n}"
    end
    password { "testtest" }
  end
end
