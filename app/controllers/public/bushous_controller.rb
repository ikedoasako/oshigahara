class Public::BushousController < ApplicationController

  def index
    @bushou = Bushou.new
    @bushous = Bushou.all
    #ページネーション
    @bushous = Bushou.page(params[:page]).per(10)

    @top_bushou = @bushous.order(tally: :desc).first
    @turn_count = User.group(:old_bushou_id).count.reject{|k, v| k == nil }

  end

  def show
    @bushou =Bushou.find(params[:id])
  end

  private

  def bushou_params
    params.require(:bushou).permit(:bushou_name, :explanation)
  end

end
