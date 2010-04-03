require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before :each do
    @user = User.make
    @deck = @user.decks.make
    
    @card1 = @deck.cards.make
    @card2 = @deck.cards.make
    @card3 = @deck.cards.make
    @card4 = @deck.cards.make
    @card5 = @deck.cards.make
    
    @card1.update_attributes(:next_repetition => nil)
    @card2.update_attributes(:next_repetition => Date.today)
    @card3.update_attributes(:next_repetition => Date.today - 1)
    @card4.update_attributes(:next_repetition => Date.today + 2)
    @card5.update_attributes(:next_repetition => Date.today + 2)
  end 
  
  describe 'scheduling' do
    
    it 'should return a calendar with the next 30 days scheduled' do
      @user.schedule.events.length.should == 2
      
      today = @user.schedule.events[0]
      today.dtstart.should == (Date.today + @user.time_scheduled_for_recalls.hours).to_datetime.to_s
      today.dtend.should == (Date.today + @user.time_scheduled_for_recalls.hours + 1.hour).to_datetime.to_s
      
      day_after_tomorrow = @user.schedule.events[1]
      day_after_tomorrow.dtstart.should == ((Date.today + 2) + @user.time_scheduled_for_recalls.hours).to_datetime.to_s
      day_after_tomorrow.dtend.should == ((Date.today + 2) + @user.time_scheduled_for_recalls.hours + 1.hour).to_datetime.to_s
    end
    
  end
  
  describe 'pending study cards' do
    it 'should return all cards (since none studied)' do
      @user.pending_cards_to_study.length.should == 3
      @user.pending_cards_to_study.should == [@card3, @card2, @card1]
    end

    it 'should only study pending cards if more than daily card quota ' do
      @user.update_attributes(:daily_card_quota => 1)
      @user.pending_cards_to_study.length.should == 2
      @user.pending_cards_to_study.should == [@card3, @card2]
    end
    
    it 'should return part of the pending cards' do
      @user.update_attributes(:daily_card_quota => 1)

      @card6 = @deck.cards.make
      @card6.update_attributes(:next_repetition => nil)

      @user.pending_cards_to_study.length.should == 2
      @user.pending_cards_to_study.should == [@card3, @card2]

      @user.update_attributes(:daily_card_quota => 3)

      @user.pending_cards_to_study.length.should == 3
      @user.pending_cards_to_study.should == [@card3, @card2, @card1]
    end
  end
end
