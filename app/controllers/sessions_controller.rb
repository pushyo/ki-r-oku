class SessionsController < ApplicationController
  
  def new
    @title = 'Sign in'
  end

  def create
    if user = User.authenticate(params[:session][:email], 
                                params[:session][:password]) 
      #TODO
      salt = BCrypt::Password.new(user.password_digest).salt
      cookies.permanent.signed[:user] = [ user.id, salt ]
      @debug_info = { :cookies => cookies , :salt => salt}
    else
      #TODO
      @title = 'Sign in'
      render :new
    end
  end

  def delete
  end

end
