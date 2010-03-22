require 'spec_helper'

describe CardsController do
  integrate_views 

  before :each do
    @card = Card.make
    
    UserSession.create(@card.deck.user)
  end
  
  describe "GET show" do
    it "should be successful" do
      get :show, :id => @card.id
      response.status.should == '200 OK'
    end
  end

  describe "GET edit" do
    it "should be successful" do
      get :edit, :id => @card.id
      response.status.should == '200 OK'
    end
  end
  
  

end
