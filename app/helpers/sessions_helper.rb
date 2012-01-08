module SessionsHelper
  def sign_in( user )
    cookies.permanent.signed[:remember_me] = [ user.id, user.salt ]
  end
    
  def sign_out
    cookies.delete(:remember_me)
    current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end

  def remember_token
   cookies.signed[:remember_me] || [nil, nil] 
  end

  # friendly redirection

  def deny_access
    store_location
    redirect_to signin_path, :notice => "you need to be logged in to perform this action"
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_return_to
    session[:return_to] = nil
  end
 
end
