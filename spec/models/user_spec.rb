require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できない場合' do

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
        @user.email = 'test@example.com'
        expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid, /Email has already been taken/)
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

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'password'
        @user.valid?
        expect(@user.errors[:password]).to include('is invalid')
      end
      
      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors[:password]).to include('is invalid')
      end
      
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'パスワード１'
        @user.valid?
        expect(@user.errors[:password]).to include('is invalid')
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password_confirmation = 'mismatched_password'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it 'お名前(全角)は、名字が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors[:last_name]).to include("can't be blank")
      end

      it 'お名前(全角)は、名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors[:first_name]).to include("can't be blank")
      end

      it '名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'Smith'
        @user.valid?
        expect(@user.errors[:last_name]).to include('is invalid')
      end

      it 'お名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'John'
        @user.valid?
        expect(@user.errors[:first_name]).to include('is invalid')
      end

      it 'お名前カナ(全角)は、名字が必須であること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include("can't be blank")
      end

      it 'お名前カナ(全角)は、名前が必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include("can't be blank")
      end

      it '名字カナは、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'すみす'
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include('is invalid')
      end

      it 'お名前カナは、全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include('is invalid')
      end

      it '生年月日が必須であること' do
        @user.birthdate = nil
        @user.valid?
        expect(@user.errors[:birthdate]).to include("can't be blank")
      end
    end
    context '新規登録できる場合' do
      it "適切なデータが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
  end
end
