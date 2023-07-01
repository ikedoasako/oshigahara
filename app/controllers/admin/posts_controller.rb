class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts = Ppst.page(params[:page])
  end

  def show
  end

  def edit
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :bushou_id, :title, :body)
  end
end
