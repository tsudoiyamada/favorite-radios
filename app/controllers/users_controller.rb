class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :likes]
  before_action :correct_user, only: [:edit, :show]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @radios = @user.radios.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報は正常に更新されました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報は更新されませんでした。'
      render :edit
    end 
  end 
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    counts(@user)
  end 
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :image, :remove_image)
  end 
  
  def correct_user
    @user = current_user
    unless @user
      redirect_to root_url
    end 
  end 
end 

