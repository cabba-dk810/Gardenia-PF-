# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context '入力が必須であること' do
    it 'ユーザネーム(user_name)は必須であること' do
      @user = FactoryBot.build(:user, user_name: nil)
      expect(@user.valid?).to eq(false)
    end

    it 'メールアドレス(email)は必須であること' do
      @user = FactoryBot.build(:user, email: nil)
      expect(@user.valid?).to eq(false)
    end

    it 'パスワード(password)は必須であること' do
      @user = FactoryBot.build(:user, password: nil)
      expect(@user.valid?).to eq(false)
    end

    it '郵便番号(postal_code)は必須であること' do
      @user = FactoryBot.build(:user, postal_code: nil)
      expect(@user.valid?).to eq(false)
    end

    it '県(prefecture)は必須であること' do
      @user = FactoryBot.build(:user, prefecture: nil)
      expect(@user.valid?).to eq(false)
    end

    it '住所(address)は必須であること' do
      @user = FactoryBot.build(:user, address: nil)
      expect(@user.valid?).to eq(false)
    end

    it '電話番号(phone_number)は必須であること' do
      @user = FactoryBot.build(:user, phone_number: nil)
      expect(@user.valid?).to eq(false)
    end
  end

  context '文字制限が有効であること' do

    it '郵便番号(postal_code)は6文字で保存できないこと' do
      @user.postal_code = '1' * 6
      expect(@user).not_to be_valid
    end
    it '郵便番号(postal_code)は8文字で保存できないこと' do
      @user.postal_code = '8' * 8
      expect(@user).not_to be_valid
    end

    it '住所(address)は71文字で保存できないこと' do
      @user.address = 'a' * 71
      expect(@user).not_to be_valid
    end
    it '住所(address)は70文字で保存できること' do
      @user.address = 'a' * 70
      expect(@user).to be_valid
    end

    it '電話番号(phone_number)は16文字で保存できないこと' do
      @user.phone_number = 'a' * 16
      expect(@user).not_to be_valid
    end
    it '電話番号(phone_number)は15文字で保存できること' do
      @user.phone_number = 'a' * 15
      expect(@user).to be_valid
    end

    it 'プロフィール文(profile_text)は101文字で保存できないこと' do
      @user.profile_text = 'a' * 101
      expect(@user).not_to be_valid
    end
    it 'プロフィール文(profile_text)は100文字で保存できること' do
      @user.profile_text = 'a' * 100
      expect(@user).to be_valid
    end
  end
end
