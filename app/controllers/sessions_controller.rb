class SessionsController < ApplicationController
  
  def new
    @title = 'Sign in'
    #@debug_info = { :cookies => cookies }
  end

  def create
    if user = User.authenticate(params[:session][:email], 
                                params[:session][:password]) 
      sign_in user
      flash[:success] = "Welcome, #{user.name}!"
      redirect_back_or user
    else
      @title = 'Sign in'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
