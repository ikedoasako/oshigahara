class Public::UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
        redirect_to users_my_page_path
    else
     render :edit
    end
  end

  def betray
    #@user = User.new(user_params)
    @user =current_user

  end

  def betrayed
    #ページ表示するだけ
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

  private

  def user_params
      params.require(:user).permit(:bushou_id, :name, :email, :is_deleted)
  end

end
