require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '新規登録ができない時' do
      
      it '商品画像が必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors[:image]).to include("can't be blank")
      end

      it '商品名が必須であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors[:name]).to include("can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors[:description]).to include("can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors[:category_id]).to include("can't be blank")
      end

      it '商品の状態の情報が必須であること' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors[:condition_id]).to include("can't be blank")
      end

      it '配送料の負担の情報が必須であること' do
        @item.shipping_fee_covered_id = 0
        @item.valid?
        expect(@item.errors[:shipping_fee_covered_id]).to include("can't be blank")
      end

      it '発送元の地域の情報が必須であること' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors[:prefecture_id]).to include("can't be blank")
      end

      it '発送までの日数の情報が必須であること' do
        @item.delivery_period_id = 0
        @item.valid?
        expect(@item.errors[:delivery_period_id]).to include("can't be blank")
      end

      it '価格の情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors[:price]).to include("can't be blank")
      end

      it '価格が整数であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors[:price]).to include("is not a number")
      end

      it '価格が300未満だと出品できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors[:price]).to include('must be greater than or equal to 300')
      end

      it '価格が10000000以上だと出品できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors[:price]).to include('must be less than or equal to 9999999')
      end

      it '価格が半角数値のみ保存可能であること' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors[:price]).to include('is not a number')
      end
    end

    context '新規登録ができる時' do
      it '適切なデータが存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end
  end
end