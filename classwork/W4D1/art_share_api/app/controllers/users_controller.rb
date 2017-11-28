class UsersController < ApplicationController
  def index
    if params[:search]
      search_query = "%#{params[:search].downcase}%"
      users = User.where('LOWER(username) LIKE ?', search_query)

      return render json: "not found" if users.empty?
      render json: users
    else
      render json: User.all
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])

    if user.destroy
      render json: "DESTROYED"
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
