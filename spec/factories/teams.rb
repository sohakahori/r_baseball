FactoryBot.define do
  factory :team do
    sequence(:name) do |n|
      "テスト #{n}"
    end
    sequence(:stadium) do |n|
      "テストドーム#{n}"
    end
    address { "テスト住所" }
    league { 1 }

    trait :name_of_nil do
      name { nil }
    end

    trait :league_of_nil do
      league { nil }
    end

    trait :league_of_nil do
      league { nil }
    end

    trait :stadium_of_nil do
      stadium { nil }
    end

    trait :address_of_nil do
      address { nil }
    end
  end
end
