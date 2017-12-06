class SubsController < ApplicationController
  before_action :require_login
  before_action :require_mod, only: [:update, :destroy]
  
  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.mod = current_user
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def index
    @subs = Sub.all
  end
  
  def require_mod
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless @sub.mod == current_user
  end
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
