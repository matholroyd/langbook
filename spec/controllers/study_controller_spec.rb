require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StudyController do
  before :each do
    @user = User.make
    UserSession.create(@user)
  end
  
  describe "GET start" do
    it "should be successful" do
      get :start, :user_id => @user.id
      response.status.should == '200 OK'
    end
  end

end
