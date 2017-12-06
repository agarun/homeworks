class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    
    if user
      login(user)
      redirect_to subs_url
    else
      flash[:errors] = ["invalid credentials"]
      render :new
    end
  end

  def destroy
    logout
  end
  
end
