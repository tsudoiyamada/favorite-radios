class RadiosController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  protect_from_forgery :except => [:destroy]
  
  def show
    @radio = Radio.find(params[:id])
  end 
  
  def new
    @radio = Radio.new
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
  
  def destroy
    @radio.destroy
    flash[:success] = 'マイラジオを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def edit
    @radio = Radio.find(params[:id])
  end
  
  def update
    @radio = Radio.find(params[:id])
    
    if @radio.update(radio_params)
      flash[:success] = 'マイラジオは正常に更新されました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'マイラジオは更新されませんでした。'
      render :edit   
    end 
  end 
  
  private
  
  def radio_params
    params.require(:radio).permit(:title, :introduction, :image, :remove_image, :start_at, :end_at)
  end 
  
  def correct_user
    @radio = current_user.radios.find_by(id: params[:id])
    unless @radio
      redirect_to root_url
    end 
  end 
end
