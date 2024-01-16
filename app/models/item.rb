class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user

  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_covered
  belongs_to :prefecture
  belongs_to :delivery_period

  has_one_attached :image
  
  with_options presence: true do
    validates :user_id
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_fee_covered_id
    validates :prefecture_id
    validates :delivery_period_id
    validates :price,numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :condition_id
    validates :prefecture_id
    validates :shipping_fee_covered_id
    validates :delivery_period_id
  end
end