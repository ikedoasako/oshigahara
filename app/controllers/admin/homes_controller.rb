class Admin::HomesController < ApplicationController

  def top
    @posts = Post.page(params[:page])
    @user = []
    @posts.each do |post|
      @user << post.user
    end
    #@user = @posts.map(&:user)
    
    @posts = Post.page(params[:page]).reverse_order
  end

end
