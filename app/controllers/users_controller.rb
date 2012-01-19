class UsersController < ApplicationController
before_filter :authenticate, :only => [:index, :edit, :update]
before_filter :check_user, :only => [:edit, :update]
before_filter :check_admin, :only => :destroy
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @records = @user.records.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
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

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end
  
  protected

  def authenticate
    deny_access unless signed_in?
  end

  def check_user
    @user = User.find_by_id(params[:id])
    redirect_to root_path unless current_user?(@user) 
  end

  def check_admin
    redirect_to root_path unless current_user.admin?
  end

end
