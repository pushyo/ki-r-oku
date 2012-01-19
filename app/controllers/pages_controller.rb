class PagesController < ApplicationController
  def home
    redirect_to new_record_path if signed_in?
    @title = "Home"
    @records = Record.published.paginate( :page => 1, :per_page => 5 )
  end

  def contact
    @title = "Contact"
  end

  def feed
    @title = "Feed"
    @records = Record.paginate(:page => params[:page], :per_page =>20)
  end

end
