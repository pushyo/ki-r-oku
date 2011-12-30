require 'spec_helper'

describe "LayoutLinks" do

  describe "GET 'home'" do
    it "should have a homepage at '/'" do
      get '/'
      response.should be_success
    end
  end

end
