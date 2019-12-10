class LikesController < ApplicationController
	def create
		@post_garden = PostGarden.find(params[:id])
		like = current_user.likes.build(post_garden_id: params[:id], user_id: current_user.id)
		like.save
	end

	def destroy
		@post_garden = PostGarden.find(params[:id])
		like = Like.find_by(post_garden_id: params[:id], user_id: current_user.id)
		like.destroy
	end
end
