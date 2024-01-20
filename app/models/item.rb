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
    validates :image
    validates :name
    validates :description
    validates :category_id, :condition_id, :shipping_fee_covered_id, :prefecture_id, :delivery_period_id,
              numericality: { other_than: 0, message: 'can\'t be blank' }
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
end
