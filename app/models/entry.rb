class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  belongs_to :meaning_language
  
  validates_presence_of :user_id, :standard_form, :transliteration, :language_id

  def set_transliteration_via_standard_form
    language.set_transliterate(self)
  end
  
end
