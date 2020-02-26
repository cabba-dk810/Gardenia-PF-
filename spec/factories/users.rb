# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user_name { 'daichi' }
    postal_code { 3800803 }
    prefecture { 12 }
    address { '長野県長野市三輪3-9-12' }
    phone_number { '07010400683' }
    profile_text { 'よろしくお願いします' }
    email { 'fswamd@yahoo.co.jp' }
    password { '1111111' }
  end
end
