class StudyController < ApplicationController
  skip_before_filter :require_user, :only => [:schedule]
  before_filter :find_user

  def start
  end

  def schedule
    send_data(@user.schedule.export, :type => 'text/calendar', :disposition => 'inline')
  end
  
  def cards
    @cards = @user.cards.scheduled_to_recall_up_to(Date.today)
    respond_to do |format|
      format.json do
        render :json => @cards.to_json
      end
    end
  end
  
  def process_recall_result
    @card = @user.cards.find(params[:id])
    @card.process_recall_result(params[:quality_of_recall].to_i)
    @card.save!
    
    render :json => @card.to_json(:methods => 'scheduled_to_recall?')
  end
  
  private 
  
  def find_user
    @user = User.find(params[:user_id])
  end
end
