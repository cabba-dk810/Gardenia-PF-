class PostCommentsController < ApplicationController
	def create
		post_garden = PostGarden.find(params[:post_garden_id])
		@post_comment = current_user.post_comments.new(post_comment_params)
		@post_comment.post_garden_id = post_garden.id
		@post_comment.save
		# コメントの通知
		post_garden.create_notification_comment!(current_user, @post_comment.id)
		redirect_to post_garden_path(post_garden)
	end

	def destroy
		@post_garden = PostGarden.find(params[:id])
		@post_comment = PostComment.find(params[:post_garden_id])
		@post_comment.destroy
		redirect_to post_garden_path(@post_garden)
	end

	private

	def post_comment_params
		params.require(:post_comment).permit(:user_id, :post_garden_id, :comment_content)
	end
end
