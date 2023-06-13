class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id,
                :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  POSTAL_CODE_REGEX = /\A\d{3}-\d{4}\z/.freeze
  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: POSTAL_CODE_REGEX, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number
  end
  validates :phone_number, numericality: { only_integer: true, message: 'is invalid. Input only number' },
                           length: { in: 10..11, message: 'is too short' }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                   address: address, building: building, phone_number: phone_number,
                   order_id: order.id)
  end
end
