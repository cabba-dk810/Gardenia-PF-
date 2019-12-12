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
			puts @post_garden.errors.full_messages
			puts @post_image.errors.full_messages
			puts @planted_garden.errors.full_messages
			render 'new'
		end
	end

	def index
		@post_gardens = PostGarden.all
	end

	def search_result
		@q = PostGarden.ransack(params[:q])
	    @post_gardens = @q.result(distinct: true)
	end

	def show
		@post_garden = PostGarden.find(params[:id])
		@user = User.find_by(id: @post_garden.user_id)
		@post_comment = PostComment.new
	end

	def edit
		@post_garden = PostGarden.find(params[:id])
	end

	def update
		@post_garden = PostGarden.find(params[:id])
		if @post_garden.update(post_garden_params)
			redirect_to post_garden_path(params[:id])
		else
			render 'edit'
		end
	end

	def destroy
		@post_garden = PostGarden.find(params[:id])
		@post_garden.destroy
		redirect_to user_path(current_user.id)
	end

	def new_open_garden
		@post_garden = PostGarden.find(params[:id])
		@open_day = OpenDay.new

		@open_day_up = OpenDay.new
		@open_day_up.post_garden_id = params[:id]
		# @open_day_up.start_time = DateTime.parse(params[:open_day]["start_time(1i)"] + "-" + params[:open_day]["start_time(2i)"] + "-" + params[:open_day]["start_time(3i)"] + " " + params[:open_day]["start_time(4i)"] + ":" + params[:open_day]["start_time(5i)"]).to_s
		# @open_day_up.end_time = DateTime.parse(params[:open_day]["end_time(1i)"] + "-" + params[:open_day]["end_time(2i)"] + "-" + params[:open_day]["end_time(3i)"] + " " + params[:open_day]["end_time(4i)"] + ":" + params[:open_day]["end_time(5i)"]).to_s
		# @open_day = OpenDay.new(post_garden_id: params[:open_day][:post_garden_id], start_time: @open_day.start_time, end_time: @open_day.end_time)

		# イベント取得用
		@open_days = OpenDay.where(post_garden_id: params[:id])

	end

	def delete_open_info
		@post_garden = PostGarden.find(params[:id])
		# 日程を全て削除
		@open_days = OpenDay.where(post_garden_id: @post_garden.id)

		@post_garden.update_attributes(open_status: 0)
		redirect_to post_garden_path(params[:id])
	end

	def about

	end

	private

	def post_garden_params
		params.require(:post_garden).permit(:post_content, :place, :area, :price, :problem, :solution, :open_status, :open_postal_code, :open_prefecture, :open_address, :open_max_number, :open_entrance_fee, :open_announce, :tag_list, post_images_attributes:[:garden_image, :_destroy
	], planted_gardens_attributes: [:id, :plant_name, :plant_number, :_destroy])
	end

end
