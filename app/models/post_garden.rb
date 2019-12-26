class PostGarden < ApplicationRecord
	enum open_prefecture: { "北海道": 0, "青森県": 1, "岩手県": 2, "宮城県": 3, "秋田県": 4, "山形県": 5, "福島県": 6, "茨城県": 7, "栃木県": 8, "群馬県": 9, "埼玉県": 10, "千葉県": 11, "東京都": 12, "神奈川県": 13, "新潟県": 14, "富山県": 15, "石川県": 16, "福井県": 17, "山梨県": 18, "長野県": 19, "岐阜県": 20, "静岡県": 21, "愛知県": 22, "三重県": 23, "滋賀県": 24, "京都府": 25, "大阪府": 26, "兵庫県": 27, "奈良県": 28, "和歌山県": 29, "鳥取県": 30, "島根県": 31, "岡山県": 32, "広島県": 33, "山口県": 34, "徳島県": 35, "香川県": 36, "愛媛県": 37, "高知県": 38, "福岡県": 39, "佐賀県": 40, "長崎県": 41, "熊本県": 42, "大分県": 43, "宮崎県": 44, "鹿児島県": 45, "沖縄県": 46 }
	enum open_status: { "非公開": 0, "公開": 1}

	validates :post_content, presence: true, length: { maximum: 200 }


	belongs_to :user

	has_many :post_images, dependent: :destroy
	accepts_nested_attributes_for :post_images, allow_destroy: true
	accepts_attachments_for :post_images, attachment: :garden_image

	has_many :planted_gardens
	accepts_nested_attributes_for :planted_gardens, allow_destroy: true

	has_many :open_days, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :post_comments, dependent: :destroy
	has_many :reservations, dependent: :destroy

	# タグ付用記述
	acts_as_taggable

	# 住所入力時に緯度経度も自動で保存
	geocoded_by :address
	after_validation :geocode


	# 通知用記述
	has_many :notifications, dependent: :destroy


	# いいねが１投稿につき１人１回
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

	# 以下通知機能のメソッド
	# いいねの通知機能
	def create_notification_like!(current_user)
		# 既に「いいねされているか検索
		temp = Notification.where(["visitor_id = ? and visited_id = ? and post_garden_id = ? and action = ? ", current_user.id, user_id, id, 'like'])

		# いいねされていない場合のみ、通知レコードを作成
		if temp.blank?
			notification = current_user.active_notifications.new(
				post_garden_id: id,
				visited_id: user_id,
				action: 'like'
			)
			# 自分の投稿に対するいいねの場合は、通知済とする
			if notification.visitor_id == notification.visited_id
				notification.checked = true
			end
			notification.save if notification.valid?
		end
	end

	# コメントの通知機能
	def create_notification_comment!(current_user, post_comment_id)
		# 自分以外にコメントしている人を全て取得し、全員に通知を送る
		temp_ids = PostComment.select(:user_id).where(post_garden_id: id).where.not(user_id: current_user.id).distinct
		temp_ids.each do |temp_id|
			save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
		end

		# まだ誰もコメントしていない場合は、投稿者に通知を送る
		save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
	end

	def save_notification_comment!(current_user, post_comment_id, visited_id)
		# コメントは複数回することができるため、一つの投稿に複数回通知する
		notification = current_user.active_notifications.new(
			post_garden_id: id,
			post_comment_id: post_comment_id,
			visited_id: visited_id,
			action: 'comment'
		)

		# 自分の投稿に対するコメントは通知済みとする
		if notification.visitor_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end


end
