# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'バリデーションのテスト' do
    context '入力が必須であること' do
      let(:user) { FactoryBot.build(:user) }
      subject { user.valid? }

      it 'ユーザネーム(user_name)は必須であること' do
        user.user_name = nil
        is_expected.to eq(false)
      end

      it 'メールアドレス(email)は必須であること' do
        user.email = nil
        is_expected.to eq(false)
      end

      it 'パスワード(password)は必須であること' do
        user.password = nil
        is_expected.to eq(false)
      end

      it '郵便番号(postal_code)は必須であること' do
        user.postal_code = nil
        is_expected.to eq(false)
      end

      it '県(prefecture)は必須であること' do
        user.prefecture = nil
        is_expected.to eq(false)
      end

      it '住所(address)は必須であること' do
        user.address = nil
        is_expected.to eq(false)
      end

      it '電話番号(phone_number)は必須であること' do
        user.phone_number = nil
        is_expected.to eq(false)
      end
    end

    context '文字制限が有効であること' do
      let(:user) { FactoryBot.build(:user) }
      subject { user }

      it 'ユーザー名(user_name)は16文字で保存できないこと' do
        user.user_name = 'f' * 16
        is_expected.not_to be_valid
      end
      it 'ユーザー名(user_name)は15文字で保存できること' do
        user.user_name = 'f' * 15
        is_expected.to be_valid
      end

      it '郵便番号(postal_code)は6文字で保存できないこと' do
        user.postal_code = '1' * 6
        is_expected.not_to be_valid
      end
      it '郵便番号(postal_code)は8文字で保存できないこと' do
        user.postal_code = '8' * 8
        is_expected.not_to be_valid
      end

      it '住所(address)は71文字で保存できないこと' do
        user.address = 'a' * 71
        is_expected.not_to be_valid
      end
      it '住所(address)は70文字で保存できること' do
        user.address = 'a' * 70
        is_expected.to be_valid
      end

      it '電話番号(phone_number)は16文字で保存できないこと' do
        user.phone_number = 'a' * 16
        is_expected.not_to be_valid
      end
      it '電話番号(phone_number)は15文字で保存できること' do
        user.phone_number = 'a' * 15
        is_expected.to be_valid
      end

      it 'プロフィール文(profile_text)は101文字で保存できないこと' do
        user.profile_text = 'a' * 101
        is_expected.not_to be_valid
      end
      it 'プロフィール文(profile_text)は100文字で保存できること' do
        user.profile_text = 'a' * 100
        is_expected.to be_valid
      end
    end
  end

  describe 'dependent destroyが機能しているか' do
    before do
      @user = FactoryBot.create(:user)
      @post_garden = PostGarden.create(user_id: @user.id, post_content: 'good garden')
    end

    it 'userを削除すると、userの投稿も削除されること' do
      expect{ @user.destroy }.to change{ PostGarden.count }.by(-1)
    end

    it 'userを削除すると、userのいいねも削除されること' do
      @user.likes.create(user_id: @user.id, post_garden_id: @post_garden.id)
      expect{ @user.destroy }.to change{ Like.count }.by(-1)
    end

    it 'userを削除すると、userのコメントも削除されること' do
      @user.post_comments.create(user_id: @user.id, post_garden_id: @post_garden.id, comment_content: 'very good')
      expect{ @user.destroy }.to change{ PostComment.count }.by(-1)
    end
  end

end
