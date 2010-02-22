class DecksController < ApplicationController
  resource_controller  
  
  create.wants.html { redirect_to deck_path(object) }
  destroy.wants.html { redirect_to user_decks_path(object.user_id) }
  
  belongs_to :user
end
