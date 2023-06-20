class Admin::BushousController < ApplicationController

  before_action :authenticate_admin!

  def new
    @bushou = Bushou.new
  end

  def create
    @bushou = Bushou.new(bushou_params)
    #binding.pry
    if @bushou.save
      flash[:notice] = "You have created bushou successfully"
      redirect_to admin_bushous_path(@bushou)
    else
      #@bushous = Bushou.all
      render :index
    end
  end

  def show
    @bushou =Bushou.find(params[:id])
  end

  def index
    #@bushous = Bushou.all
    @bushous = Bushou.page(params[:page])
  end

  def edit
    @bushou = Bushou.find(params[:id])
  end

  def update
    @bushou = Bushou.find(params[:id])
    if @bushou.update(bushou_params)
      flash[:notice] = "編集しました"
      redirect_to admin_bushous_path
    else
      render :edit
    end
  end

  private

  def bushou_params
    params.require(:bushou).permit(:image, :bushou_name, :explanation)
  end
end
