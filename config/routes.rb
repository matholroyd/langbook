ActionController::Routing::Routes.draw do |map|
  map.resources :cards

  map.resource :user_session, :except => [:edit, :show, :update]
  map.resources :users, :shallow => true do |users|
    users.resources :decks, :shallow => true do |decks|
      decks.resources :cards
    end
  end

  map.controller_actions 'home', %w{testing}

  map.root :controller => 'home', :action => 'index'
end
