# frozen_string_literal: true

class PostGardensController < ApplicationController
  def new
    @post_garden = PostGarden.new

    @post_image = @post_garden.post_images.build
    @planted_garden = @post_garden.planted_gardens.build
  end

  def send_images
    # postアクションなので、strongparameterを設定する必要がある
    send_images = Vision.get_image_ajax(send_image_params[:image])
    translations = []
    send_images.each do |send_image|
      translate_result = Translation.get_label_data(send_image['description'])
      add_translations = { 'keyword' => translate_result.to_s }
      translations.push(add_translations)
    end
    render json: translations
  end

  def create
    @post_garden = PostGarden.new(post_garden_params)
    @post_garden.user_id = current_user.id
    if @post_garden.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    # 新着の投稿
    @post_gardens = PostGarden.all.order(created_at: :desc).limit(12).includes([:user]).includes([:post_images]).includes([:taggings])
    # いいね数順
    @rank_orders = PostGarden.all.order(likes_count: :desc).limit(12).includes([:user]).includes([:post_images]).includes([:taggings])

    if user_signed_in?
      # フォローしているユーザの投稿
      @followings = Relationship.where(user_id: current_user.id)
      @following_posts = []
      # フォローしている人１人ずつに対して
      @followings.each do |follow|
        posts = PostGarden.where(user_id: follow.follow_id).includes([:user]).includes([:post_images]).includes([:taggings])
        @following_posts.concat(posts)
      end
      # フォローしているユーザの全投稿を並び替える
      @order_following_posts = @following_posts.sort_by!(&:created_at).reverse.slice(0..11)
    end

    # 公開している庭一覧（Googlemapにピンを立てる）
    @open_gardens = PostGarden.where(open_status: 1)
    # 新着公開中庭園
    @open_gardens_side = PostGarden.where(open_status: 1).limit(3).order('created_at DESC').includes([:post_images])

    # よく使うタグを取ってくる（デフォルトで20件）
    @tags = ActsAsTaggableOn::Tag.most_used
  end

  def search_result
    # 検索パラメータはapplicationcontrollerで設定済
    # よく使うタグを取ってくる（デフォルトで20件）
    @tags = ActsAsTaggableOn::Tag.most_used

    # タグをクリックしたときの検索結果
    @post_gardens = PostGarden.all.includes([:post_images]).includes([:user]).includes([:taggings])
    @post_gardens = if params[:tag_name]
                      @post_gardens.tagged_with(params[:tag_name].to_s)
                    else
                      @search.result(distinct: true)
                    end
    # 新着公開中庭園
    @open_gardens_side = PostGarden.where(open_status: 1).limit(3).order('created_at DESC').includes([:post_images])
  end

  def show
    @post_garden = PostGarden.find(params[:id])
    @post_comments = PostComment.where(post_garden_id: @post_garden.id).includes([:user])
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

    @open_days.each(&:destroy)

    @post_garden.update_attributes(open_status: 0)
    redirect_to post_garden_path(params[:id])
  end

  def about; end

  private

  def post_garden_params
    params.require(:post_garden).permit(:post_content, :place, :area, :price, :problem, :solution, :open_status, :open_postal_code, :open_prefecture, :address, :latitude, :longitude, :open_max_number, :open_entrance_fee, :open_announce, :tag_list, post_images_attributes: %i[id garden_image _destroy], planted_gardens_attributes: %i[id plant_name plant_number _destroy])
  end

  def send_image_params
    params.permit(:image)
  end
end
