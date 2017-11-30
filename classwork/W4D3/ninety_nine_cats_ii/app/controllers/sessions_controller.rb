class SessionsController < ApplicationController
  before_action :already_logged_in, only: [:new, :create]

  def new
    render :new
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
      flash.now[:errors] = ["invalid credentials"]
      render :new
    end
  end

  def destroy
    if current_user
      logout
      redirect_to cats_url
    end
  end

end
