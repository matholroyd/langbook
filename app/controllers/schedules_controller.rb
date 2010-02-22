class SchedulesController < ApplicationController
  skip_before_filter :require_user, :only => [:caldav]
  
  before_filter :find_user

  def show
  end
  
  def caldav
    respond_to do |format|
      format.ics { send_data(@user.schedule.export, :type => 'text/calendar', :disposition => 'inline') }
    end
  end
  
  private 
  
  def find_user
    @user = User.find(params[:user_id])
  end
end
