class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :decks
  has_many :cards, :through => :decks

  default_value_for :daily_card_quota, 30

  def time_scheduled_for_recalls
    10
  end
  
  def pending_cards_to_study
    result = cards.scheduled_to_recall_up_to(Date.today)
    remaining_quota = [self.daily_card_quota - result.length, 0].max
    result += cards.unstudied.find(:all, :limit => remaining_quota)
    result
  end
  
  def schedule
    RiCal.Calendar do |cal|
      cal.prodid = "Language Book//something not sure what//EN"
      def cal.add_practice(user, date, length)
        if length > 0
          self.event do |event|
            event.summary = "Pratice #{length} cards"
            event.dtstart = (date + user.time_scheduled_for_recalls.hours).to_datetime.with_floating_timezone
            event.dtend = (date + user.time_scheduled_for_recalls.hours + 1.hour).to_datetime.with_floating_timezone
            event.alarm do |alarm|
              alarm.description = "Practice"
            end
          end
        end
      end
      
      count = cards.scheduled_to_recall_up_to(Date.today).length
      cal.add_practice(self, Date.today, count)
      
      (1..30).each do |i|
        date = Date.today + i.days
        count = cards.scheduled_to_recall_on(date).length
        cal.add_practice(self, date, count)
      end
      
    end
  end
  
  private 
  
end
