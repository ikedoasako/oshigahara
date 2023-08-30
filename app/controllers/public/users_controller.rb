class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  #〜ゲストユーザーの追記〜
  #ゲストユーザーはユーザー情報の更新・削除は行えないように設定
  before_action :ensure_normal_user, only: %i[update destroy]

  def show
    if params[:id] =~ /^[0-9]+$/
      @user = User.find(params[:id])
      @posts = @user.posts
    else
      redirect_to users_betray_path
    end
  end


  def edit
    @user = current_user
  end


  def update
    @user = current_user
    if @user.update(user_params)
        redirect_to user_path(@user)
    else
     render :edit
    end
  end


  def betray
    @user =current_user

    #〜現在の武将を選択できないようにする設定〜
    #今の武将idを除いた武将idを探してくる
    @bushous = Bushou.where.not(id: @user.bushou_id)
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

  #〜ゲストユーザーの追記〜
  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to users_information_edit_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end


  def user_params
      params.require(:user).permit(:bushou_id, :name, :email, :is_deleted, :old_bushou_id)
  end
end
