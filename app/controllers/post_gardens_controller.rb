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
		# 新着の投稿
		@post_gardens = PostGarden.all.order(created_at: :desc).limit(12)
		# いいね数順
		@rank_orders = PostGarden.all.order(likes_count: :desc).limit(12)

		if user_signed_in?
		# フォローしているユーザの投稿
		@followings = Relationship.where(user_id: current_user.id)
		@following_posts = []
		# フォローしている人１人ずつに対して
		@followings.each do |follow|
			posts = PostGarden.where(user_id: follow.user_id)
			@following_posts.concat(posts)
		end
		# フォローしているユーザの全投稿を並び替える
		@order_following_posts = @following_posts.sort_by!{|post_garden| post_garden.created_at}.reverse.slice(0..11)
		end

		# 公開している庭一覧（Googlemapにピンを立てる）
		@open_gardens = PostGarden.where(open_status: 1)
	end

	def search_result
		# 検索パラメータはapplicationcontrollerでも設定済
		@search = PostGarden.ransack(params[:q])
	    @post_gardens = @search.result(distinct: true)
	end

	def show
		@post_garden = PostGarden.find(params[:id])
		@user = User.find_by(id: @post_garden.user_id)
		@post_comment = PostComment.new

		@reservation = Reservation.new

		# イベント取得用
		@open_days = OpenDay.where(post_garden_id: params[:id])
	end

	def edit
		@post_garden = PostGarden.find(params[:id])
	end

	def update
		@post_garden = PostGarden.find(params[:id])
		# @post_garden.latitude = Geocoder.coordinates(@post_garden.address[0])
		# @post_garden.longitude = Geocoder.coordinates(@post_garden.address[1])
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

		# idの情報は、更新を押した時に得られる。まだ取得できないので、空でインスタンスを作成しておく
		@open_day_updates = OpenDay.new

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
		params.require(:post_garden).permit(:post_content, :place, :area, :price, :problem, :solution, :open_status, :open_postal_code, :open_prefecture, :address, :latitude, :longitude, :open_max_number, :open_entrance_fee, :open_announce, :tag_list, post_images_attributes:[:garden_image, :_destroy
	], planted_gardens_attributes: [:id, :plant_name, :plant_number, :_destroy])
	end

end
