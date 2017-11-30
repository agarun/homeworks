class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout
    current_user.reset_session_token!
    @current_user = nil
    session[:session_token] = nil
  end
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def already_logged_in
    redirect_to cats_url if current_user
  end

  def not_logged_in
    redirect_to cats_url unless current_user
  end
end
