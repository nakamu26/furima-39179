require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  romaji = Gimei.first.romaji
  zenkaku_romaji = romaji.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
  hankaku_katakana = NKF.nkf('-w -Z4', Gimei.first.katakana)
  hiragana = Gimei.first.hiragana
  kanji = Gimei.first.kanji

  first_name_err = 'First name is invalid. Input full-width characters'
  last_name_err = 'Last name is invalid. Input full-width characters'
  first_name_kana_err = 'First name kana is invalid. Input full-width katakana characters'
  last_name_kana_err = 'Last name kana is invalid. Input full-width katakana characters'

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nickname、email、password、password_confirmation、first_name、last_name、
          first_name_kana、last_name_kana、birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

      # email
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

      # password
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Lorem.characters(number: 129, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '123xyz'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      # first_name
      it 'first_nameが半角英字では登録できない' do
        @user.first_name = romaji
        @user.valid?
        expect(@user.errors.full_messages).to include(first_name_err)
      end
      it 'first_nameが全角英字では登録できない' do
        @user.first_name = zenkaku_romaji
        @user.valid?
        expect(@user.errors.full_messages).to include(first_name_err)
      end
      it 'first_nameが半角カタカナでは登録できない' do
        @user.first_name = hankaku_katakana
        @user.valid?
        expect(@user.errors.full_messages).to include(first_name_err)
      end

      # last_name
      it 'last_nameが半角英字では登録できない' do
        @user.last_name = romaji
        @user.valid?
        expect(@user.errors.full_messages).to include(last_name_err)
      end
      it 'last_nameが全角英字では登録できない' do
        @user.last_name = zenkaku_romaji
        @user.valid?
        expect(@user.errors.full_messages).to include(last_name_err)
      end
      it 'last_nameが半角カタカナでは登録できない' do
        @user.last_name = hankaku_katakana
        @user.valid?
        expect(@user.errors.full_messages).to include(last_name_err)
      end

      # first_name_kana
      it 'first_name_kanaが半角英字では登録できない' do
        @user.first_name_kana = romaji
        @user.valid?
        expect(@user.errors.full_messages).to include(first_name_kana_err)
      end
      it 'first_name_kanaが全角英字では登録できない' do
        @user.first_name_kana = zenkaku_romaji
        @user.valid?
        expect(@user.errors.full_messages).to include(first_name_kana_err)
      end
      it 'first_name_kanaが半角カタカナでは登録できない' do
        @user.first_name_kana = hankaku_katakana
        @user.valid?
        expect(@user.errors.full_messages).to include(first_name_kana_err)
      end
      it 'first_name_kanaがひらがなでは登録できない' do
        @user.first_name_kana = hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include(first_name_kana_err)
      end
      it 'first_name_kanaが漢字では登録できない' do
        @user.first_name_kana = kanji
        @user.valid?
        expect(@user.errors.full_messages).to include(first_name_kana_err)
      end

      # last_name_kana
      it 'last_name_kanaが半角英字では登録できない' do
        @user.last_name_kana = romaji
        @user.valid?
        expect(@user.errors.full_messages).to include(last_name_kana_err)
      end
      it 'last_name_kanaが全角英字では登録できない' do
        @user.last_name_kana = zenkaku_romaji
        @user.valid?
        expect(@user.errors.full_messages).to include(last_name_kana_err)
      end
      it 'last_name_kanaが半角カタカナでは登録できない' do
        @user.last_name_kana = hankaku_katakana
        @user.valid?
        expect(@user.errors.full_messages).to include(last_name_kana_err)
      end
      it 'last_name_kanaがひらがなでは登録できない' do
        @user.last_name_kana = hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include(last_name_kana_err)
      end
      it 'last_name_kanaが漢字では登録できない' do
        @user.last_name_kana = kanji
        @user.valid?
        expect(@user.errors.full_messages).to include(last_name_kana_err)
      end
    end
  end
end
