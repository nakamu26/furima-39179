class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  NAME_KANA_REGEX = /\A[ァ-ヶー]+\z/.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  with_options presence: true do
    validates :nickname
    validates :birth_date
    with_options format: { with: NAME_REGEX, message: 'is invalid. Input full-width characters' } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: NAME_KANA_REGEX, message: 'is invalid. Input full-width katakana characters' } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end
  validates :password,
            format: { with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers' }
end
