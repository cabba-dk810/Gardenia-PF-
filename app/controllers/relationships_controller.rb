class RelationshipsController < ApplicationController

	def create
		user = User.find(params[:follow_id])
		following = current_user.follow(user)
		if following.save
			user.create_notification_follow!(current_user)
			redirect_to user_path(user)
		end
	end

	def destroy
		user = User.find(params[:follow_id])
		following = current_user.unfollow(user)
		if following.destroy
			redirect_to user_path(user)
		end
	end
end
