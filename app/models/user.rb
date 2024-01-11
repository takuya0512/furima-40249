class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :last_name, :first_name, :birthday, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A\S+@\S+\z/ }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/ }
  validates :password_confirmation, presence: true, if: :password
  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[\p{Katakana}\p{Blank}ー－]+\z/ }
end
