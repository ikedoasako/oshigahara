class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end


  def edit
    @user = current_user
  end


  def update
    @user = current_user
    if @user.update(user_params)
        redirect_to users_path
    else
     render :edit
    end
  end


  def betray
    @user =current_user
  end


  def betrayed
    @user = current_user
    user_betray_params = user_params
    user_betray_params[:old_bushou_id] = @user.bushou_id

    unless @user.update(user_betray_params)
      render :betray
    end
  end


  def unsubscribed
    @user = current_user
  end


  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end


  private


  def user_params
      params.require(:user).permit(:bushou_id, :name, :email, :is_deleted, :old_bushou_id)
  end
end
