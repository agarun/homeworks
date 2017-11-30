class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end
  
  def show
    @cat = Cat.find(params[:id])
  end
  
  def create
    @cat = Cat.new(cat_params)
    
    if @cat.save 
      redirect_to cats_url 
    else
      render @cat.errors.full_messages 
    end 
    
  end
  
  def new
    @cat = Cat.new
  end
  
  def edit
    @cat = Cat.find(params[:id])
  end

  def update 
    @cat = Cat.find(params[:id])
    
    if @cat.update(cat_params)
      redirect_to cats_url 
    else 
      render @cat.errors.full_messages
    end 
  end 
  private
  
  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end
end
