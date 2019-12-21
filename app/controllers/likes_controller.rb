class LikesController < ApplicationController
	def create
		@post_garden = PostGarden.find(params[:id])
		like = current_user.likes.build(post_garden_id: params[:id], user_id: current_user.id)
		like.save
		# いいねに通知機能
		@post_garden.create_notification_like!(current_user)
	end

	def destroy
		@post_garden = PostGarden.find(params[:id])
		like = Like.find_by(post_garden_id: params[:id], user_id: current_user.id)
		like.destroy
	end
end
