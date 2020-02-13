# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_gardens = PostGarden.where(user_id: @user.id).includes([:post_images]).includes([:user]).includes([:taggings])
    @relationship = Relationship.new

    @relationship_followers = Relationship.where(follow_id: @user.id)
    @relationship_followings = Relationship.where(user_id: @user.id)

    # カレンダーに登録するイベント
    if user_signed_in?
      @visit_requests = Reservation.where(user_id: current_user.id).where(request_status: '承認')
      @accept_requests = Reservation.where(owner_id: current_user.id).where(request_status: '承認')
    end
  end

  def edit
    @user = User.find(params[:id])

    @visit_requests = Reservation.where(user_id: current_user.id).where(request_status: '承認')
    @accept_requests = Reservation.where(owner_id: current_user.id).where(request_status: '承認')
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
    @user = User.find(params[:id])
  end

  def follower
    @user = User.find(params[:id])
    @followers = Relationship.where(follow_id: params[:id]).includes([:user])
    @relationship = Relationship.new
  end

  def following
    @user = User.find(params[:id])
    @followings = Relationship.where(user_id: params[:id]).includes([:follow])
    @relationship = Relationship.new
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :postal_code, :prefecture, :address, :phone_number, :email, :profile_image, :profile_text)
  end
end
