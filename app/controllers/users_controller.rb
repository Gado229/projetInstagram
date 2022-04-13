class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :likes]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update

    @user = User.find(params[:id])

    if @user.update(user_params)
      puts 'user_save'
      redirect_to @user
    else
      puts 'user_not_save'
      puts @user.errors.full_messages
      render :edit
    end
  end

  def likes
    @loves = User.find(current_user.id).loves.order(id: "desc")
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache )
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to blogs_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
