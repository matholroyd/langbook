require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
 
describe EntriesController do
  integrate_views 

  before :each do
    @user = User.make
    @entry = @user.entries.make
    
    UserSession.create(@user)
  end
  
  describe "GET show" do
    it "should be successful" do
      get :show, :id => @entry.id
      response.status.should == '200 OK'
    end
  end

  describe "GET edit" do
    it "should be successful" do
      get :edit, :id => @entry.id
      response.status.should == '200 OK'
    end
  end
  
  
  

end