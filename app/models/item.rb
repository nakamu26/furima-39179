class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  HALF_WIDTH_NUMBER = /\A[0-9]+\z/.freeze
  validates :image, attached_file_presence: true
  with_options presence: true do
    validates :name
    validates :description
    validates :price_before_type_cast, format: { with: HALF_WIDTH_NUMBER, message: 'is invalid. Input half-width characters' },
                                       numericality: { only_integer: true, greater_than_or_equal_to: 300,
                                                       less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
  end
  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end
end
