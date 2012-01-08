class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def current_user
    @current_user ||= User.authenticate_with_token(*remember_token)
  end
  helper_method :current_user

  protected

  def authenticate
    deny_access unless signed_in?
  end

end
