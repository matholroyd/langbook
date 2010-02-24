class StudyController < ApplicationController
  skip_before_filter :require_user, :only => [:schedule]
  before_filter :find_user

  def start
  end

  def schedule
    send_data(@user.schedule.export, :type => 'text/calendar', :disposition => 'inline')
  end
  
  private 
  
  def find_user
    @user = User.find(params[:user_id])
  end
end
