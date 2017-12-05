class GoalsController < ApplicationController
  before_action :require_logged_in
  
  def new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(current_user)
  end

  def edit
    
  end

  def update
    @goal = current_user.goals.find(params[:id])
      
    if @goal.update_attributes(goal_params)
      redirect_to user_url(current_user)
    else
      flash[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:goal)
  end
end
