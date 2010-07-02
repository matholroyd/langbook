ActionController::Routing::Routes.draw do |map|

  map.resource :user_session, :except => [:edit, :show, :update]

  map.resources :users, :shallow => true do |users|
    users.resources :entries
    users.resources :decks do |decks|
      decks.resources :cards
    end
  end

  map.study '/users/:user_id/study/:action.:format', :controller => 'study'

  map.root :controller => 'home', :action => 'index'
  map.controller_actions 'home', %w{testing}
end
