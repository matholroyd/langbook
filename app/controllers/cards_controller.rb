class CardsController < ApplicationController
  resource_controller  
  belongs_to :deck
  
  index.wants.json { render :json => @cards.to_json(Card::ATTR_FOR_JSON) }
  create.wants.html { redirect_to card_path(object) }
  destroy.wants.html { redirect_to deck_path(object.deck_id) }

  protected
  
  def collection
    @cards ||= @deck.cards.find(:all, :include => :deck)
  end
end
