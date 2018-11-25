FactoryBot.define do
  factory :user do
    sequence(:first_name) do |n|
      "first_name #{n}"
    end

    sequence(:last_name) do |n|
      "last_name #{n}"
    end

    sequence(:email) do |n|
      "test@test#{n}.com"
    end
    password { 'testtest' }
  end
end
