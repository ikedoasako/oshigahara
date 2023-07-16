class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    
    
    if comment.save
      redirect_to post_path(post)
    else
      @post = post
      @user = @post.user
      @comment = comment
  
      #複数タグの追記
      @post_tags = @post.tags
      
      render "/public/posts/show.html.erb"
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = current_user.comments.find_by(id: params[:id])
    comment.destroy
    redirect_to post_path(post)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
