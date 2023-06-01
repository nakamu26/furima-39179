class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  NAME_KANA_REGEX = /\A[ァ-ヶー]+\z/.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :nickname,        presence: true
  validates :last_name,       presence: true,
                              format: { with: NAME_REGEX, message: 'is invalid. Input full-width characters' }
  validates :first_name,      presence: true,
                              format: { with: NAME_REGEX, message: 'is invalid. Input full-width characters' }
  validates :last_name_kana,  presence: true,
                              format: { with: NAME_KANA_REGEX, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, presence: true,
                              format: { with: NAME_KANA_REGEX, message: 'is invalid. Input full-width katakana characters' }
  validates :birth_date,      presence: true
  validates :password,
            format: { with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers' }
end
