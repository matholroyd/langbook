class DecksController < ApplicationController
  resource_controller  
  belongs_to :user

  destroy.wants.html { redirect_to user_decks_path(object.user_id) }

  def create
    @user = parent_object
    @deck = parent_object.decks.create params[:deck]
    @deck.valid?
    
    bad_file = false
    @file = params[:file]
    if @file
      FasterCSV.parse(@file.read) do |row|
        @file.close
        if row.length != 2
          bad_file = true
          break
        else 
          @deck.cards.build :question => row[0], :answer => row[1]
        end
      end
    end
        
    if bad_file || !@deck.valid?
      @deck.errors.add_to_base("Import file is not a CSV file in the format \"Question\", \"Answer\"") if bad_file
      render :action => 'new'
    else
      @deck.save!
      redirect_to deck_path(@deck)
    end
  end
  
end
