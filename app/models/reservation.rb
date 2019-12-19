class Reservation < ApplicationRecord
	enum request_status: { "未受付": 0, "承認": 1, "キャンセル": 2}

	belongs_to :user
	belongs_to :post_garden
end
