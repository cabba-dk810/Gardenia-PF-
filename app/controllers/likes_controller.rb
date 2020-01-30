# frozen_string_literal: true

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

  def index
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id).includes([:user]).includes([post_garden: :post_images]).includes([post_garden: :user]).includes([post_garden: :taggings])
    @tags = ActsAsTaggableOn::Tag.most_used
  end
end
