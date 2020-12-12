class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    radio = Radio.find(params[:radio_id])
    current_user.favorite(radio)
    flash[:success] = 'お気に入り登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    radio = Radio.find(params[:radio_id])
    current_user.unfavorite(radio)
    flash[:success] = 'お気に入り解除しました。'
    redirect_back(fallback_location: root_path)
  end
end

