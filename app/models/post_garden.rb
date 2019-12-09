class PostGarden < ApplicationRecord
	enum prefecture: { "北海道": 0, "青森県": 1, "岩手県": 2, "宮城県": 3, "秋田県": 4, "山形県": 5, "福島県": 6, "茨城県": 7, "栃木県": 8, "群馬県": 9, "埼玉県": 10, "千葉県": 11, "東京都": 12, "神奈川県": 13, "新潟県": 14, "富山県": 15, "石川県": 16, "福井県": 17, "山梨県": 18, "長野県": 19, "岐阜県": 20, "静岡県": 21, "愛知県": 22, "三重県": 23, "滋賀県": 24, "京都府": 25, "大阪府": 26, "兵庫県": 27, "奈良県": 28, "和歌山県": 29, "鳥取県": 30, "島根県": 31, "岡山県": 32, "広島県": 33, "山口県": 34, "徳島県": 35, "香川県": 36, "愛媛県": 37, "高知県": 38, "福岡県": 39, "佐賀県": 40, "長崎県": 41, "熊本県": 42, "大分県": 43, "宮崎県": 44, "鹿児島県": 45, "沖縄県": 46 }
	enum open_status: { "非公開": 0, "公開": 1}

	validates :post_content, presence: true, length: { maximum: 200 }


	belongs_to :user

	has_many :post_images
	accepts_nested_attributes_for :post_images, allow_destroy: true
	accepts_attachments_for :post_images, attachment: :garden_image

	has_many :planted_gardens
	accepts_nested_attributes_for :planted_gardens, allow_destroy: true

	has_many :open_days

	has_many :likes, dependent: :destroy

	# タグ付用記述
	acts_as_taggable


	# いいねが１投稿につき１人１回
	def liked_by?(user_id)
		likes.where(user_id: user_id).exists?
	end


end
