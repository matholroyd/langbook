require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Card do
  before :each do
    @card = Card.make
  end

  it 'should make a valid card' do
    @card.should be_valid
  end

  it 'should have the necessary methods' do
    @card.check_spaced_repetition_methods
  end
  
  it 'should reset values for new card' do
    @card.easiness_factor.should == 2.5  
    @card.number_repetitions.should == 0  
    @card.quality_of_last_recall.should == nil  
    @card.repetition_interval.should == nil
    @card.next_repetition.should == nil 
    @card.should_not be_scheduled_to_recall
  end
  
  it 'should schedule the next recall' do
    @card.process_recall_result(4)
    @card.next_repetition.should == (Date.today + 1)
    @card.should_not be_scheduled_to_recall
  end
  
  it 'should schedule to recall today' do
    @card.process_recall_result(0)
    @card.next_repetition.should == Date.today
    @card.should be_scheduled_to_recall 
  end
  
  [:question, :answer].each do |field|
    describe field do
      before :each do
        @card = Card.make
        @formatted_field = "#{field}_formatted"
      end
    
      it 'should set RedCloth formatted fields before save' do
        @card.send(@formatted_field).should == "<p>#{@card.send(field)}</p>" 
      end
    end
  end
  
  describe 'named_scope' do
    before :each do 
      @user = User.make
      
      @deckA = @user.decks.make
      @deckB = @user.decks.make
      
      @cardA1 = @deckA.cards.make
      @cardA2 = @deckA.cards.make

      @cardB1 = @deckB.cards.make
      @cardB2 = @deckB.cards.make
      
      @cardA1.update_attributes(:next_repetition => nil)
      @cardA2.update_attributes(:next_repetition => Date.today)
      @cardB1.update_attributes(:next_repetition => Date.today - 1)
      @cardB2.update_attributes(:next_repetition => Date.today + 1)
    end
  
    it 'should find all the cards scheduled to be recalled up to a particular day' do
      @user.cards.scheduled_to_recall_up_to(Date.today - 2).should == []
      @user.cards.scheduled_to_recall_up_to(Date.today - 1).should == [@cardB1]
      @user.cards.scheduled_to_recall_up_to(Date.today).should == [@cardB1, @cardA2]
      @user.cards.scheduled_to_recall_up_to(Date.today + 1).should == [@cardB1, @cardA2, @cardB2]
      @user.cards.scheduled_to_recall_up_to(Date.today + 2).should == [@cardB1, @cardA2, @cardB2]
    end

    it 'should find all the cards scheduled to be recalled on a particular day' do
      @user.cards.scheduled_to_recall_on(Date.today - 2).should == []
      @user.cards.scheduled_to_recall_on(Date.today - 1).should == [@cardB1]
      @user.cards.scheduled_to_recall_on(Date.today).should == [@cardA2]
      @user.cards.scheduled_to_recall_on(Date.today + 1).should == [@cardB2]
      @user.cards.scheduled_to_recall_on(Date.today + 2).should == []
    end
    
    it 'should find all the cards that have never been studied, in order of created' do
      user = User.make
      deck = user.decks.make
      card = deck.cards.make
      
      user.cards.unstudied.should == [card]
      
      card.process_recall_result(4)
      card.save

      user.cards.unstudied.should == []
    end
    
  end
  
end
