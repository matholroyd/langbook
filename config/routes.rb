ActionController::Routing::Routes.draw do |map|

  map.resource :user_session, :except => [:edit, :show, :update]

  map.resources :users, :shallow => true do |users|
    users.resources :decks, :shallow => true do |decks|
      decks.resources :cards
    end
    users.resource :schedule, :member => {:caldav => :get}
  end

  map.root :controller => 'home', :action => 'index'
  map.controller_actions 'home', %w{testing}
end
