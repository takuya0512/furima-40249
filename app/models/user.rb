class User < ApplicationRecord  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  with_options presence: true do
    validates :nickname
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX
    validates :last_name,             format: { with: /\A[\p{Han}\p{Hiragana}\p{Katakana}]+\z/ }
    validates :first_name,            format: { with: /\A[\p{Han}\p{Hiragana}\p{Katakana}]+\z/ }
    validates :last_name_kana,        format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }
    validates :first_name_kana,       format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }
    validates :birthdate
  end
end
