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
  validates :image,                  attached_file_presence: true
  validates :name,                   presence: true
  validates :description,            presence: true
  validates :category_id,            numericality: { other_than: 0, message: "can't be blank" }
  validates :condition_id,           numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :prefecture_id,          numericality: { other_than: 0, message: "can't be blank" }
  validates :scheduled_delivery_id,  numericality: { other_than: 0, message: "can't be blank" }
  validates :price_before_type_cast, presence: true,
                                     format: { with: HALF_WIDTH_NUMBER, message: 'is invalid. Input half-width characters' },
                                     numericality: { only_integer: true, greater_than_or_equal_to: 300,
                                                     less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
end
