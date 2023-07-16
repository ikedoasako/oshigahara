class Public::PostsController < ApplicationController

  before_action :authenticate_user!

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
    @post = Post.new
    @user = current_user

    #タグ検索機能・ページネーション追加
    if params[:tag_ids].present?
      tag = Tag.find(params[:tag_ids])
      @posts = tag.posts.page(params[:page])
    else
      @posts = Post.page(params[:page]).reverse_order
    end
    #複数タグの追記
    @tag_list=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new

    #複数タグの追記
    @post_tags = @post.tags
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


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    #formで取得したパラメータをモデルに渡す
    @posts = Post.search(params[:search])
  end



  private

  def post_params
    params.require(:post).permit(:title, :body, :bushou_id, :user_id, :image, tag_ids: [])
  end

end
