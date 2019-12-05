class PostImage < ApplicationRecord
	belongs_to :post_garden

	attachment :garden_image
end
