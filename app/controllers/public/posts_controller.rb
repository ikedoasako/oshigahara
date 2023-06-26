class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
    
  end
  
  
  def create
    @post = Post.new(post_params)
    if @post.save
        flash[:notice] = "投稿しました"
       redirect_to posts_path
    else
       render :new
    end
  end
  
  
  def index
    @posts = Post.all
  end


  def show
    @post = Post.find(params[:id])  
  end


  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       flash[:notice] = "編集しました"
       redirect_to posts_path
    else
       render :edit
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :bushou_id, :user_id)
  end
  
end
