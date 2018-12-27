FactoryBot.define do
  factory :player do
    association :team
    sequence(:no) do |n|
      n
    end
    name { 'テスト選手' }
    position { 'pitcher' }
    birthday { '1992/02/21' }
    height { 178 }
    weight { 78 }
    throw { 'right_throw' }
    hit { 'right_hit' }
    detail { '詳細内容' }

    trait :detail_of_nil do
      detail { nil }
    end

    trait :no_of_nil do
      no { nil }
    end

    trait :no_of_string do
      no { '背番号' }
    end

    trait :name_of_nil do
      name { nil }
    end

    trait :birthday_of_nil do
      birthday { nil }
    end

    trait :position_of_nil do
      position { nil }
    end

    trait :height_of_nil do
      height { nil }
    end

    trait :height_of_string do
      height { '身長' }
    end

    trait :height_of_a_digit do
      height { 1 }
    end

    trait :height_of_four_digit do
      height { 1234 }
    end

    trait :weight_of_string do
      weight { '体重' }
    end

    trait :weight_of_a_digit do
      weight { 1 }
    end

    trait :weight_of_four_digit do
      weight { 1234 }
    end

    trait :throw_of_nil do
      throw { nil }
    end

    trait :hit_of_nil do
      hit { nil }
    end
  end
end
