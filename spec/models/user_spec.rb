require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors[:nickname]).to include("can't be blank")
    end

    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'メールアドレスが一意性であること' do
      existing_user = FactoryBot.create(:user, email: 'test@example.com')
  
  

  # 同じメールアドレスを持つ別のユーザーを作成
  @user.email = 'test@example.com'

  # 保存が失敗し、エラーメッセージが期待通りに生成されることを期待するブロック
  expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid, /Email has already been taken/)



      # existing_user = FactoryBot.create(:user, email: 'test@example.com')
      # @user.email = 'test@example.com'
      # @user.valid?
      # expect(@user.errors[:email]).to include('has already been taken')
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'invalid_email'
      @user.valid?
      expect(@user.errors[:email]).to include('is invalid')
    end

    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = 'passw'
      @user.valid?
      expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password = 'password'
      @user.valid?
      expect(@user.errors[:password]).to include('is invalid')
    end

    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      @user.password_confirmation = 'mismatched_password'
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
      @user.last_name = ''
      @user.first_name = ''
      @user.valid?
      expect(@user.errors[:last_name]).to include("can't be blank")
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.last_name = 'Smith'
      @user.first_name = 'John'
      @user.valid?
      expect(@user.errors[:last_name]).to include('is invalid')
      expect(@user.errors[:first_name]).to include('is invalid')
    end

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
      @user.last_name_kana = ''
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include("can't be blank")
      expect(@user.errors[:first_name_kana]).to include("can't be blank")
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.last_name_kana = 'すみす'
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include('is invalid')
      expect(@user.errors[:first_name_kana]).to include('is invalid')
    end

    it '生年月日が必須であること' do
      @user.birthdate = nil
      @user.valid?
      expect(@user.errors[:birthdate]).to include("can't be blank")
    end
  end
end




# # 省略
#       it 'nickname:必須' do
#         @user.nickname = ''
#         @user.valid?
#         expect(@user.errors.full_messages).to include("Nickname can't be brank")
#       end
# # 省略
#   end
# end

#   it 'validates presence of nickname' do
#     user = User.new(nickname: nil)
#     expect(user.valid?).to be_falsey
#     expect(user.errors[:nickname]).to include("can't be blank")
#   end

#   it 'validates presence of email' do
#     user = User.new(email: nil)
#     expect(user.valid?).to be_falsey
#     expect(user.errors[:email]).to include("can't be blank")
#   end

#   it 'validates uniqueness of email' do
#     existing_user = FactoryBot.create(:user, email: 'test@example.com')
#     user = User.new(email: 'test@example.com')
#     expect(user.valid?).to be_falsey
#     expect(user.errors[:email]).to include('has already been taken')
#   end

#   # 他のバリデーションに対するテストも同様に記述

# end




# it '重複したemailが存在する場合は登録できない' do
#   @user.save
#   another_user = FactoryBot.build(:user, email: @user.email)
#   another_user.valid?
#   expect(another_user.errors.full_messages).to include('Email has already been taken')
# end

# it 'emailは@を含まないと登録できない' do
#   @user.email = 'testmail'
#   @user.valid?
#   expect(@user.errors.full_messages).to include('Email is invalid')
# end