class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    #byebug
    #〜複数タグを持たせるための追記〜
    tag_id_lists=params[:post][:tag_ids].compact.reject(&:empty?)
    # ["", "1", "2"] → ["1", "2"]
    #受け取った値を加工する

    post_tag = @post.post_tags.build

    #タグで入力した値を収めている（tag_id_lists)
    tag_id_lists.each do |tag_id|
      #中間テーブルの作成
      #post_tag = PostTag.new(tag_id: ~~~)と同じ
      post_tag.tag = Tag.find_by(id: tag_id.to_i)
    end

    if @post.save
      tag_id_lists.each do |tag_id|
        #余分な中間テーブルの作成
        if PostTag.where(post_id: @post.id, tag_id: tag_id).count >= 2
          PostTag.find_by(post_id: @post.id, tag_id: tag_id).delete
        end
      end
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

    #タグ検索機能の追記
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
                                        #tag_idの登録があったらTagモデルと関連付けしたpostsから持ってくる
                                        #tag_idがなかったら全ての投稿を表示させる
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
    # @post = Post.find(params[:id])
    # @post.destroy
    # redirect_to posts_path
    
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
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
