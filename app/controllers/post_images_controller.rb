# frozen_string_literal: true

class PostImagesController < ApplicationController
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to edit_post_garden_path(@post_image.post_garden_id)
  end
end
