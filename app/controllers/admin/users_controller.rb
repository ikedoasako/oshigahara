class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
    @users = User.page(params[:page]).reverse_order

  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編集しました"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted, :bushou_id)
  end
end
