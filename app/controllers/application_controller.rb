class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in
    # if current_user return true, then it returns logged in
    !!current_user
  end

  def require_user
    # if user is logged out, then do actions below
    if !logged_in
      flash[:notice] = "You must be logged in to perform this action!"
      redirect_to root_path
    end
  end


end
