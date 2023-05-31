require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  ROMAJI = Gimei.first.romaji
  ZENKAKU_ROMAJI = ROMAJI.tr('0-9a-zA-Z','０-９ａ-ｚＡ-Ｚ')
  HANKAKU_KATAKANA = NKF.nkf('-w -Z4', Gimei.first.katakana)
  HIRAGANA = Gimei.first.hiragana
  KANJI = Gimei.first.kanji

  FIRST_NAME_ERR = 'First name is invalid. Input full-width characters'
  LAST_NAME_ERR = 'Last name is invalid. Input full-width characters'
  FIRST_NAME_KANA_ERR = 'First name kana is invalid. Input full-width katakana characters'
  LAST_NAME_KANA_ERR = 'Last name kana is invalid. Input full-width katakana characters'


  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nickname、email、password、password_confirmation、first_name、last_name、
          first_name_kana、last_name_kana、birth_dateが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it "birth_dateが空では登録できない" do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

      #　email
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      #　password
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Lorem.characters(number: 129, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '123xyz'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      #　first_name
      it 'first_nameが半角英字では登録できない' do
        @user.first_name = ROMAJI
        @user.valid?
        expect(@user.errors.full_messages).to include(FIRST_NAME_ERR)
      end
      it 'first_nameが全角英字では登録できない' do
        @user.first_name = ZENKAKU_ROMAJI
        @user.valid?
        expect(@user.errors.full_messages).to include(FIRST_NAME_ERR)
      end
      it 'first_nameが半角カタカナでは登録できない' do
        @user.first_name = HANKAKU_KATAKANA
        @user.valid?
        expect(@user.errors.full_messages).to include(FIRST_NAME_ERR)
      end

      #　last_name
      it 'last_nameが半角英字では登録できない' do
        @user.last_name = ROMAJI
        @user.valid?
        expect(@user.errors.full_messages).to include(LAST_NAME_ERR)
      end
      it 'last_nameが全角英字では登録できない' do
        @user.last_name = ZENKAKU_ROMAJI
        @user.valid?
        expect(@user.errors.full_messages).to include(LAST_NAME_ERR)
      end
      it 'last_nameが半角カタカナでは登録できない' do
        @user.last_name = HANKAKU_KATAKANA
        @user.valid?
        expect(@user.errors.full_messages).to include(LAST_NAME_ERR)
      end
      
      #　first_name_kana
      it 'first_name_kanaが半角英字では登録できない' do
        @user.first_name_kana = ROMAJI
        @user.valid?
        expect(@user.errors.full_messages).to include(FIRST_NAME_KANA_ERR)
      end
      it 'first_name_kanaが全角英字では登録できない' do
        @user.first_name_kana = ZENKAKU_ROMAJI
        @user.valid?
        expect(@user.errors.full_messages).to include(FIRST_NAME_KANA_ERR)
      end
      it 'first_name_kanaが半角カタカナでは登録できない' do
        @user.first_name_kana = HANKAKU_KATAKANA
        @user.valid?
        expect(@user.errors.full_messages).to include(FIRST_NAME_KANA_ERR)
      end
      it 'first_name_kanaがひらがなでは登録できない' do
        @user.first_name_kana = HIRAGANA
        @user.valid?
        expect(@user.errors.full_messages).to include(FIRST_NAME_KANA_ERR)
      end
      it 'first_name_kanaが漢字では登録できない' do
        @user.first_name_kana = KANJI
        @user.valid?
        expect(@user.errors.full_messages).to include(FIRST_NAME_KANA_ERR)
      end

      #　last_name_kana
      it 'last_name_kanaが半角英字では登録できない' do
        @user.last_name_kana = ROMAJI
        @user.valid?
        expect(@user.errors.full_messages).to include(LAST_NAME_KANA_ERR)
      end
      it 'last_name_kanaが全角英字では登録できない' do
        @user.last_name_kana = ZENKAKU_ROMAJI
        @user.valid?
        expect(@user.errors.full_messages).to include(LAST_NAME_KANA_ERR)
      end
      it 'last_name_kanaが半角カタカナでは登録できない' do
        @user.last_name_kana = HANKAKU_KATAKANA
        @user.valid?
        expect(@user.errors.full_messages).to include(LAST_NAME_KANA_ERR)
      end
      it 'last_name_kanaがひらがなでは登録できない' do
        @user.last_name_kana = HIRAGANA
        @user.valid?
        expect(@user.errors.full_messages).to include(LAST_NAME_KANA_ERR)
      end
      it 'last_name_kanaが漢字では登録できない' do
        @user.last_name_kana = KANJI
        @user.valid?
        expect(@user.errors.full_messages).to include(LAST_NAME_KANA_ERR)
      end
    end
  end
end
