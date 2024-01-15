class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_covered
  belongs_to :prefecture
  belongs_to :delivery_period
  has_one_attached :image

  # app/models/product.rb
class Product < ApplicationRecord
  # 画像のバリデーション
  validates :image, presence: true

  # 商品名のバリデーション
  validates :name, presence: true

  # 商品説明のバリデーション
  validates :description, presence: true

  # カテゴリーのバリデーション
  validates :category, presence: true

  # 商品の状態のバリデーション
  validates :condition, presence: true

  # 配送料の負担のバリデーション
  validates :shipping_fee, presence: true

  # 発送元の地域のバリデーション
  validates :origin, presence: true

  # 発送までの日数のバリデーション
  validates :shipping_days, presence: true

  # 価格のバリデーション
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  # 価格が半角数値のみ保存可能であることを確認する正規表現を使用
  validates_format_of :price, with: /\A[0-9]+\z/, message: "は半角数値で入力してください"
end

end