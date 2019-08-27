class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]
  # before_action :correct_user,   only: [:edit, :update]
  def new
    unless user_signed_in?
      @user  = User.new
    else
      redirect_to '/'
    end
  end

  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to '/dashboard'
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)   
    if @user.save
      flash[:success] = "Welcome to the file sharing app!"
      log_in @user
      redirect_to '/dashboard'
    else
      render 'new'
    end
  
  end
  
  def edit
    @user = User.find(params[:id])
  end

end

private
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  
