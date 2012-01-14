class PagesController < ApplicationController
  def home
    @title = "Home"
    @record = Record.new if signed_in?
  end

  def contact
    @title = "Contact"
  end

  def feed
    @title = "Feed"
    @records = Record.paginate(:page => params[:page])
  end

end
