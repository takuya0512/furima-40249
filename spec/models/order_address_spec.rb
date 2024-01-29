
require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end
  
  describe '配送先情報の保存' do
    context '配送先情報の保存ができる場合' do
      it '適切なデータが存在すれば保存できる' do
        expect(@order_address).to be_valid
      end

      it '建物名の記入がなくても登録できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '配送先情報の保存ができない場合' do
      it 'user_idが空だと保存できないこと' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors[:user_id]).to include("can't be blank")
      end

      it 'item_idが空だと保存できないこと' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors[:item_id]).to include("can't be blank")
      end

      it '郵便番号が空だと保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors[:postal_code]).to include("can't be blank")
      end

      it '郵便番号は「3桁ハイフン4桁」でないと保存できないこと' do
        @order_address.postal_code = 12_345_678
        @order_address.valid?
        expect(@order_address.errors[:postal_code]).to include('is invalid. Include hyphen(-)')
      end

      it '都道府県が空だと保存できないこと' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors[:prefecture_id]).to include("can't be blank")
      end

      it '市区町村が空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors[:city]).to include("can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors[:block]).to include("can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include("can't be blank")
      end

      it '電話番号にハイフンがあると保存できないこと' do
        @order_address.phone_number = '012 - 1234 - 5678'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is invalid')
      end

      it '電話番号は半角数値のみ保存可能であること' do
        @order_address.phone_number = '０１２１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is invalid')
      end

      it '電話番号は10桁未満だと保存できないこと' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is invalid')
      end

      it '電話番号は11桁以上だと保存できないこと' do
        @order_address.phone_number = '111122223333'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is invalid')
      end

      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
