class Public::HomesController < ApplicationController
  def top
    @bushous = Bushou.page(params[:page]).per(15).shuffle
    @posts = Post.page(params[:page]).per(15).shuffle
  end

  def about
  end

end
