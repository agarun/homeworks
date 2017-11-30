class SessionsController < ApplicationController
  before_action :already_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    
    if user
      login(user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    if current_user
      session[:session_token] = nil
      current_user.reset_session_token!
      @current_user = nil
      redirect_to cats_url
    end
  end

end
