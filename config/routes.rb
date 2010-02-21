ActionController::Routing::Routes.draw do |map|
  map.resource :user_session, :except => [:edit, :show, :update]
  map.resources :users

  map.controller_actions 'home', %w{testing}

  map.root :controller => 'home', :action => 'index'
end
