FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { Faker::Lorem.characters(number: 10, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    nickname { Faker::Name.last_name }
    first_name_kana { Gimei.first.katakana }
    last_name_kana { first_name_kana }
    first_name { Gimei.first.kanji + Gimei.first.hiragana + first_name_kana }
    last_name { first_name }
    birth_date { Faker::Date.between(from: '1930-01-01', to: Date.today) }
  end
end
