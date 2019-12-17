class PostImage < ApplicationRecord
	belongs_to :post_garden

	attachment :garden_image

#	validates :garden_image_id, presence: true
end
