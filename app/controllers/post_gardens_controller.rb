class PostGardensController < ApplicationController
	def new
		@post_garden = PostGarden.new
		@post_image = @post_garden.post_images.build
		@planted_garden = @post_garden.planted_gardens.build
	end

	def create
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def new_open_garden
	end

	def about
	end

	private

	def post_garden_params
		params.require(:post_garden).permit(:post_content, :place, :area, :price, :problem, :solution, :open_status, :open_postal_code, :open_prefecture, :open_address, :open_max_number, :open_entrance_fee, :open_announce, post_images_attributes: [:id, :garden_image_id])
	end

end
