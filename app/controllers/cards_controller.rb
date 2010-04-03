class CardsController < ApplicationController
  resource_controller  
  belongs_to :deck
  
  index.wants.json { render :json => @cards.to_json(Card::ATTR_FOR_JSON) }
  create.wants.html { redirect_to card_path(object) }
  destroy.wants.html { redirect_to deck_path(object.deck_id) }
end
