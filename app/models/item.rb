class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates :image,                  attached_file_presence: true
  validates :name,                   presence: true
  validates :description,            presence: true
  validates :category_id,            numericality: { other_than: 0, message: "can't be blank" }
  validates :condition_id,           numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :prefecture_id,          numericality: { other_than: 0, message: "can't be blank" }
  validates :scheduled_delivery_id,  numericality: { other_than: 0, message: "can't be blank" }
  validates :price,                  presence: true,
                                     inclusion: { in: 300..9_999_999, message: 'is out of setting range' },
                                     numericality: { message: 'is invalid. Input half-width characters' }
end
