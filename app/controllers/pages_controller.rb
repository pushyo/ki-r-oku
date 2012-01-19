class PagesController < ApplicationController
  def home
    @title = "Home"
    redirect_to new_record_path if signed_in?
  end

  def contact
    @title = "Contact"
  end

  def feed
    @title = "Feed"
    @records = Record.paginate(:page => params[:page], :per_page =>20)
  end

end
