class UsersController < ApplicationController
  skip_before_filter :require_user, :only => [:new, :create]

  resource_controller  
  
  create.wants.html { redirect_to root_path}
end
