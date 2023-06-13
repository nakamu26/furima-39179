class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
