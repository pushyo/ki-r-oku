require 'spec_helper'
require 'ruby-debug'

describe RecordsController do
  render_views

  describe "access control" do
    
    describe "for not signed-in user" do

      before(:each) do
        @user = User.first || User.create( :name => "user", :email => "user@fake.com", :password => "fakepass" )
        @record = @user.records.first  || @user.records.create( :title => "record", :content => "hello" )
      end
      
      it "should deny access to 'index'" do
        get :index
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'show'" do
        get :show, :id => @record
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'edit'" do
        get :edit, :id => @record
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @record
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'create'" do
        post :create
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'destroy'" do
        delete :destroy, :id => @record
        response.should redirect_to(signin_path)
      end
    end

    describe "for an unauthorized user" do
      
      before(:each) do
        @user ||= User.create( :name => "yoann", :email => "fake@fake.com", :password => "fakefake")
        wrong_user ||= User.create( :name => "wrong", :email => "wrong@fake.com", :password => "fakefake")
        test_sign_in(wrong_user)
        @record = @user.records.first || @user.records.create( :title => "title", :content => "blabla" )
        @attr = { :title => "new title", :content => "updated" }
      end
      
      it "should deny access to 'destroy'" do
        delete :destroy, :id => @record
        response.should redirect_to(root_path)
      end

      it "should deny access to 'edit'" do
        get :edit, :id => @record
        response.should redirect_to(root_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @record, :user => @attr
        response.should redirect_to(root_path)
      end

    end

    describe "for an authorized user" do

      before(:each) do
        @user ||= User.create( :name => "yoann", :email => "fake@fake.com", :password => "fakefake")
        test_sign_in(@user)
        @record = @user.records.first || @user.records.create( :title => "title", :content => "blabla" )
        @attr = { :title => "new title", :content => "updated" }
      end

      it "should delete the record" do
        lambda do
          delete :destroy, :id => @record
        end.should change(Record, :count).by(-1)
      end

      it "should get edit page" do
        get :edit, :id => @record
        response.should be_success
      end

      it "should update the record" do
        put :update, :id => @record, :record => @attr
        @record.reload 
        @record.title.should == @attr[:title]
        @record.content.should == @attr[:content]
      end

    end 

  end #access_control
end
