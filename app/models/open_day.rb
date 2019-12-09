class OpenDay < ApplicationRecord
	belongs_to :post_garden

	validates :start_time, presence: true
	validates :end_time, presence: true
end
