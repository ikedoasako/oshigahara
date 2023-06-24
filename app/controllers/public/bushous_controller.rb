class Public::BushousController < ApplicationController
  
  def index
    @bushou = Bushou.new
     @bushous = Bushou.page(params[:page])
  end

  def show
    @bushou =Bushou.find(params[:id])
  end
  
  private
  
  def bushou_params
    params.require(:bushou).permit(:bushou_name, :explanation)
  end
  
end
