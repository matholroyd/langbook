class Card < ActiveRecord::Base
  include SuperMemo::SM2
  ATTR_FOR_JSON = %w{id question_formatted answer_formatted deck.name}

  before_create :reset_spaced_repetition_data
  before_save :set_formatted_fields

  belongs_to :deck
  
  validates_presence_of :question, :answer, :deck_id

  named_scope :unstudied, :conditions => {:last_studied => nil, :next_repetition => nil}
  named_scope :scheduled_to_recall_up_to, lambda { |date|
    date = Date.today if date.nil?
    {:conditions => ['next_repetition <= ?', date.to_s(:db)], :order => 'next_repetition ASC'}
  }
  named_scope :scheduled_to_recall_on, lambda { |date|
    date = Date.today if date.nil?
    {:conditions => ['next_repetition = ?', date.to_s(:db)]}
  }

  private 
  
  def set_formatted_fields
    self.question_formatted = RedCloth.new(question).to_html
    self.answer_formatted = RedCloth.new(answer).to_html
  end
  
end
