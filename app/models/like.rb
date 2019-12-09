class Like < ApplicationRecord
	belongs_to :post_garden, counter_cache: :likes_count
	belongs_to :user
end
