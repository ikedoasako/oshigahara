class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
        flash[:notice] = "攻め入りました"
       redirect_to post_path(@post.id)
    else
       @posts = Post.all
       render :index
    end
  end

  def index
    @posts = Post.all
    @post = Post.new
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end


  def edit
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id
        redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id
      redirect_to users_my_page_path
    end
    if @post.update(post_params)
       flash[:notice] = "編集しました"
       redirect_to posts_path
    else
       render :edit
    end
  end

  # def destroy
  #   @post = Post.find(params[:id])
  #   @post.destroy
  #   redirect_to posts_path
  # end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :bushou_id, :user_id, :image)
  end

end
