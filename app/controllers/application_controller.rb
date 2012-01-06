class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.authenticate_with_token(*remember_token)
  end
  helper_method :current_user

  private
  def remember_token
   cookies.signed[:remember_me] || [nil, nil] 
  end
end
