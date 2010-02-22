class Card < ActiveRecord::Base
  include SuperMemo::SM2
  before_create :reset_spaced_repetition_data

  belongs_to :deck
  
  validates_presence_of :question, :answer, :deck_id
  
  named_scope :scheduled_to_recall_up_to, lambda { |date|
    date = Date.today if date.nil?
    {:conditions => ['next_repetition <= ?', date.to_s(:db)], :order => 'next_repetition ASC'}
  }
  named_scope :scheduled_to_recall_on, lambda { |date|
    date = Date.today if date.nil?
    {:conditions => ['next_repetition = ?', date.to_s(:db)]}
  }
end
