class RecordsController < ApplicationController
  def index
    @records = current_user.records.paginate(:page => params[:page])
  end

  def create
    @record = current_user.records.build(params[:record])
    if @record.save
      redirect_to root_path
    else
      render 'pages/home'
    end
  end
end
