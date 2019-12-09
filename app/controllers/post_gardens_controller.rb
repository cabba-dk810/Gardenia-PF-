class PostGardensController < ApplicationController
	def new
		@post_garden = PostGarden.new

		@post_image = @post_garden.post_images.build
		@planted_garden = @post_garden.planted_gardens.build
	end

	def create
		@post_garden = PostGarden.new(post_garden_params)
		@post_garden.user_id = current_user.id

		# 子要素のインスタンスを作成
		@post_image = PostImage.create(
			garden_image_id: params[:post_garden][:post_images_attributes][:"0"][:garden_image]
			)

		@planted_garden = PlantedGarden.create(
			plant_name: params[:post_garden][:planted_gardens_attributes][:"0"][:plant_name],
			plant_number: params[:post_garden][:planted_gardens_attributes][:"0"][:plant_number]
			)

		if @post_garden.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def index
		@post_gardens = PostGarden.all
	end

	def show
		@post_garden = PostGarden.find(params[:id])
		@user = User.find_by(id: @post_garden.user_id)
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
		params.require(:post_garden).permit(:post_content, :place, :area, :price, :problem, :solution, :open_status, :open_postal_code, :open_prefecture, :open_address, :open_max_number, :open_entrance_fee, :open_announce, :tag_list, post_images_attributes:[:garden_image
	], planted_gardens_attributes: [:id, :plant_name, :plant_number])
	end

end
