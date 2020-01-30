# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # headerに検索ボックスが入っているので、全ページで検索パラメータを設定する
  before_action :read_ransack

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[user_name postal_code prefecture address phone_number profile_text profile_image])
  end

  def read_ransack
    @search = PostGarden.includes([:post_images]).includes([:user]).includes([:taggings]).ransack(params[:q])
  end
end
