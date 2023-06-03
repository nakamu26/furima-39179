FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    category_id { rand(1..10) }
    condition_id { rand(1..6) }
    shipping_fee_status_id { rand(1..2) }
    prefecture_id { rand(1..47) }
    scheduled_delivery_id { rand(1..3) }
    price { rand(300..9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
