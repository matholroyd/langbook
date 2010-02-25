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
  
  describe "GET cards" do
    
    describe 'today' do
      before :each do
        @deck = @user.decks.make

        @card1 = @deck.cards.make
        @card2 = @deck.cards.make
        @card3 = @deck.cards.make
        @card4 = @deck.cards.make

        @card1.update_attributes(:next_repetition => Date.today - 1)
        @card2.update_attributes(:next_repetition => Date.today)
        @card3.update_attributes(:next_repetition => Date.today + 1)
        @card4.update_attributes(:next_repetition => nil)

        get :cards, :user_id => @user.id, :format => 'json'
      end
      
      it 'should return success' do
        response.status.should == '200 OK'
      end
    
      it 'should get the flash cards for today' do
        assigns(:cards).should == [@card1, @card2]
      end
      
    end
    
  end

end
