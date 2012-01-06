class SessionsController < ApplicationController
  
  def new
    @title = 'Sign in'
    #@debug_info = { :cookies => cookies }
  end

  def create
    if user = User.authenticate(params[:session][:email], 
                                params[:session][:password]) 
      sign_in user
      redirect_to user
    else
      @title = 'Sign in'
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private
    def sign_in( user )
      cookies.permanent.signed[:remember_me] = [ user.id, user.salt ]
    end
      
    def sign_out
      cookies.delete(:remember_me)
      current_user = nil
    end

end
