require 'spec_helper'

describe SchedulesController do
  before :each do
    @user = User.make
    UserSession.create(@user)
  end
  
  describe "GET show" do
    it "should be successful" do
      get :show, :user_id => @user.id
      response.status.should == '200 OK'
    end
  end

  describe "GET update" do
    it "should be successful" do
    end
  end
end
