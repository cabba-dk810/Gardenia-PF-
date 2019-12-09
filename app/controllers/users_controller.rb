class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@post_gardens = PostGarden.where(user_id: current_user.id)
	end

	def confirm
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user.id)
		else
			render 'edit'
		end
	end

	def exit
	end

	def follower
	end

	def following
	end


	private

	def user_params
		params.require(:user).permit(:user_name, :postal_code, :prefecture, :address, :phone_number, :email, :profile_image, :profile_text)
	end

end
