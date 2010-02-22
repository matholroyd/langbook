class CardsController < ApplicationController
  resource_controller  
  belongs_to :deck
  
  create.wants.html { redirect_to card_path(object) }
  destroy.wants.html { redirect_to deck_path(object.deck_id) }
end
