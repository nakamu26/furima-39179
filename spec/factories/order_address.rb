FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    address { '1-1' }
    building { '東京ハイツ' }
    phone_number { 1234567890 } # 10桁
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
