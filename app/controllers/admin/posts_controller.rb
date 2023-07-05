class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  #homes_controller#topに記述(投稿履歴一覧)
  # def index
  #   @posts = Post.all
  #   @user = @posts.map(&:user)
  # end


  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end


  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end


  private

  def post_params
    params.require(:post).permit(:user_id, :bushou_id, :title, :body)
  end

end
