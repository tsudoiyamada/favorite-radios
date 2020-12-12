class ToppagesController < ApplicationController
  def index
    if logged_in?
      @radio = current_user.radios.build
      @radios = current_user.radios.order(id: :desc).page(params[:page]).per(10)
    end 
  end
  
  def create
    @radio = current_user.radios.build(radio_params)
    if @radio.save
      flash[:success] = 'マイラジオを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      @radios = current_user.radios.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'マイラジオの投稿に失敗しました。'
      render 'toppages/index'
    end 
  end
  
  def new
  end 
  
  private
  
  def corrent_user
    @radio = current_user.radios.find_by(id: params[:id])
    unless @radio
      redirect_to root_url
    end 
  end 
end
