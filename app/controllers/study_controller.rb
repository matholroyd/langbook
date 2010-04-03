class StudyController < ApplicationController
  skip_before_filter :require_user, :only => [:schedule]
  before_filter :find_user

  def start
    if params[:deck_id] 
      @card_path = deck_cards_path(:deck_id => params[:deck_id], :format => 'json')
    else
      @card_path = study_path(@user.id, :cards, :date => "today", :format => 'json')
    end
  end 

  def schedule
    send_data(@user.schedule.export, :type => 'text/calendar', :disposition => 'inline')
  end
  
  def cards
    @cards = @user.pending_cards_to_study
    respond_to do |format|
      format.json { render :json => @cards.to_json(Card::ATTR_FOR_JSON) }
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
