require 'spec_helper'

describe User do
  it "should be valid" do
    User.make
  end
  
  describe 'scheduling' do
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
    
    it 'should return a calendar with the next 30 days scheduled' do
      @user.schedule.events.length.should == 2
      
      today = @user.schedule.events[0]
      today.dtstart.should == (Date.today + @user.time_scheduled_for_recalls.hours).to_datetime
      today.dtend.should == (Date.today + @user.time_scheduled_for_recalls.hours + 1.hour).to_datetime
      
      day_after_tomorrow = @user.schedule.events[1]
      day_after_tomorrow.dtstart.should == ((Date.today + 2) + @user.time_scheduled_for_recalls.hours).to_datetime
      day_after_tomorrow.dtend.should == ((Date.today + 2) + @user.time_scheduled_for_recalls.hours + 1.hour).to_datetime
    end
    
  end
end
