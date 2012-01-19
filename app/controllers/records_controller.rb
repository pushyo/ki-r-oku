class RecordsController < ApplicationController
  def index
    @records = current_user.records.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @record = Record.new 
  end

  def create
    @record = current_user.records.build(params[:record])
    if @record.save
      redirect_to root_path
    else
      render 'pages/home'
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
end
