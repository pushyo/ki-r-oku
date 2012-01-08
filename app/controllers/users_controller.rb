class UsersController < ApplicationController
before_filter :authenticate, :only => [:edit, :update]
before_filter :check_user, :only => [:edit, :update]
  
  def index
    @title = "users"
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @title = "Edit profile"
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      @title = "Edit profile"
      render 'edit'
    end
  end
  
  protected

  def authenticate
    deny_access unless signed_in?
  end

  def check_user
    @user = User.find_by_id(params[:id])
    redirect_to root_path unless current_user?(@user) 
  end

end
