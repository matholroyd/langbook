require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
 
describe StudyController do
  # integrate_views 

  before :each do
    @user = User.make
    @deck = @user.decks.make

    @card1 = @deck.cards.make
    @card2 = @deck.cards.make
    @card3 = @deck.cards.make 

    @card1.update_attributes(:next_repetition => Date.today - 1)
    @card2.update_attributes(:next_repetition => Date.today)
    @card3.update_attributes(:next_repetition => Date.today + 1)
    
    UserSession.create(@user)
  end 
  
  describe "GET start" do
    it "should be successful" do
      get :start, :user_id => @user.id
      response.status.should == '200 OK'
      assigns(:card_path).should == study_path(@user.id, :cards, :date => "today", :format => 'json')
    end
    
    it 'should return specified decks cards' do
      get :start, :user_id => @user.id, :deck_id => @deck.id
      response.status.should == '200 OK'
      assigns(:card_path).should == deck_cards_path(:deck_id => @deck.id, :format => 'json')
    end
  end
  
  describe "GET cards" do
    
    describe 'today' do
      before :each do
        get :cards, :user_id => @user.id, :format => 'json'
      end
       
      it 'should return success' do
        response.status.should == '200 OK'
      end
    
      it 'should get the flash cards for today' do
        cards = assigns(:cards)
        cards.length.should == 2
        cards.include?(@card1).should be_true
        cards.include?(@card2).should be_true
      end
      
    end
    
  end
    
  describe 'PUT process_recall_result' do
    it 'should return success' do
      put :process_recall_result, :user_id => @user.id, :id => @card1.id, :quality_of_recall => 5
      response.status.should == '200 OK'
    end
    
    it 'should set the next recall date to be in the future' do
      put :process_recall_result, :user_id => @user.id, :id => @card1.id, :quality_of_recall => 5
      @card1.reload
      @card1.scheduled_to_recall?.should == false
    end

    it 'should set still require to be recalled' do
      put :process_recall_result, :user_id => @user.id, :id => @card1.id, :quality_of_recall => 0
      @card1.reload
      @card1.scheduled_to_recall?.should == true 
    end
    
    it 'should respond with card.to_json' do
      put :process_recall_result, :user_id => @user.id, :id => @card1.id, :quality_of_recall => 0
      @card1.reload
      response.body.should == @card1.to_json(:methods => 'scheduled_to_recall?')
    end
  end

end
