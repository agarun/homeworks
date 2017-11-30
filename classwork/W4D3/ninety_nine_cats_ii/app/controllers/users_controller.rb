class UsersController < ApplicationController
  before_action :already_logged_in

  def new
  end

  def create
    user = User.new(user_params)

    if user.save
      login(user)
      redirect_to cats_url
    else
      flash.now[:errors] = "invalid credentials"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
