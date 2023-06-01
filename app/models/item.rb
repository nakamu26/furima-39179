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
  validates :category_id,            numericality: { other_than: 0 }
  validates :condition_id,           numericality: { other_than: 0 }
  validates :shipping_fee_status_id, numericality: { other_than: 0 }
  validates :prefecture_id,          numericality: { other_than: 0 }
  validates :scheduled_delivery_id,  numericality: { other_than: 0 }
  validates :price,                  presence: true
end
