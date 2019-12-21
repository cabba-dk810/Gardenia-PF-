class Reservation < ApplicationRecord
	enum request_status: { "未受付": 0, "承認": 1, "キャンセル": 2}

	belongs_to :user
	belongs_to :post_garden

	has_many :notifications, dependent: :destroy


	# 予約リクエスト送付時の通知（予約者→所有者）
	def create_notification_reservation!(current_user)
		notification = current_user.active_notifications.new(
			reservation_id: id,
			post_garden_id: self.post_garden_id,
			visited_id: owner_id,
			action: 'reservation_request'
		)
		notification.save if notification.valid?
	end

	# 予約リクエスト承認時の通知（所有者→予約者）
	def approve_request_notification_reservation!(current_user)
		notification = current_user.active_notifications.new(
			reservation_id: id,
			post_garden_id: self.post_garden_id,
			visited_id: user_id,
			action: 'reservation_approve'
		)
		notification.save if notification.valid?
	end

	# 予約変更時の通知（予約者→所有者）
	def change_notification_reservation!(current_user)
		notification = current_user.active_notifications.new(
			reservation_id: id,
			post_garden_id: self.post_garden_id,
			visited_id: owner_id,
			action: 'reservation_change'
		)
		notification.save if notification.valid?
	end

	def cancel_notification_reservation!(current_user)
		# キャンセルしたのが予約者であれば、所有者に、所有者であれば予約者に通知を送る
		if current_user.id == self.user_id
			notification = current_user.active_notifications.new(
				reservation_id: id,
				post_garden_id: self.post_garden_id,
				visited_id: owner_id,
				action: 'reservation_cancel'
			)
		elsif current_user.id == self.owner_id
			notification = current_user.active_notifications.new(
				reservation_id: id,
				post_garden_id: self.post_garden_id,
				visited_id: user_id,
				action: 'reservation_cancel'
			)
		end
		notification.save if notification.valid?
	end
end
