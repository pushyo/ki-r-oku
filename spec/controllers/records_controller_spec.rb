require 'spec_helper'

describe RecordsController do
  render_views

  describe "access control" do
    
    before(:each) do
      @user = User.first || User.create( :name => "user", :email => "user@fake.com", :password => "fakepass" )
      @record = @user.records.first  || @user.records.create( :title => "record", :content => "hello" )
    end

    it "should deny access to 'show'" do
      get :show, :id => @record.id
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'edit'" do
      get :edit, :id => @record.id
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'update'" do
      put :update, :id => @record.id
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => @record.id
      response.should redirect_to(signin_path)
    end

  end
end
