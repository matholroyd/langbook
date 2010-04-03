require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe '/study/start' do
  before(:each) do
    @user = User.make    
    @deck = @user.decks.make

    @card1 = @deck.cards.make
    @card2 = @deck.cards.make
    @card3 = @deck.cards.make 

    @card1.update_attributes(:next_repetition => Date.today - 1)
    @card2.update_attributes(:next_repetition => Date.today)
    @card3.update_attributes(:next_repetition => Date.today + 1)
    
    assigns[:user] = @user
    render 'study/start'
  end

  it 'should render the activity details' do
    response.should have_text(/You have no more cards to study/)
  end
end
