class Admin::CommentsController < ApplicationController

  def index
    @comments = Comment.page(params[:page])
    @user = []
    @comments.each do |comment|
      @user << comment.user
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @user = @comment.user
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_comments_path
  end

end
