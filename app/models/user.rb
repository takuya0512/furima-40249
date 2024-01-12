class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9])/ }
  validates :password_confirmation, presence: true
  validates :last_name, presence: true, format: { with: /\A[\p{Han}\p{Hiragana}\p{Katakana}]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[\p{Han}\p{Hiragana}\p{Katakana}]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }
  validates :birthdate, presence: true
end
