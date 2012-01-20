class RecordsController < ApplicationController
  before_filter :authenticate
  before_filter :check_user, :only => [:update, :edit, :destroy]

  def index
    @records = current_user.records.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @record = Record.new 
  end

  def create
    @record = current_user.records.build(params[:record])
    if @record.save
      redirect_to @record
    else
      render 'new'
    end
  end

  def show
    @record = Record.find(params[:id])
    @user = @record.user
  end
  
  def edit
    @record = Record.find(params[:id])
    @user = @record.user
  end

  def update
    @record = Record.find(params[:id])
    if @record.update_attributes(params[:record])
      redirect_to @record
    else
      render 'edit'
    end
  end

  def destroy
    Record.find(params[:id]).destroy
    redirect_to records_path
  end

  protected
  
  def check_user
    @user = Record.find_by_id(params[:id]).user
    redirect_to root_path unless current_user?(@user)
  end

end
