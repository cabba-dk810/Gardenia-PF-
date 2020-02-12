# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:user_name) { '加藤大地' }
    sequence(:postal_code) { 3_800_803 }
    sequence(:prefecture) { 12 }
    sequence(:address) { '長野県長野市三輪3-9-12' }
    sequence(:phone_number) { '07010400683' }
    sequence(:profile_text) { 'よろしくお願いします' }
    sequence(:email) { 'fswamd@yahoo.co.jp' }
    sequence(:password) { '1111111' }
  end
end
