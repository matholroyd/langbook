class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  belongs_to :meaning_language
  
  validates_presence_of :user_id, :standard_form, :transliteration, :language_id

  attr_accessor :image_data

  def set_transliteration_via_standard_form
    language.set_transliterate(self)
  end
  
  def image_path
    "#{RAILS_ROOT}/public#{relative_path}"
  end
  
  def relative_path
    "/images/entries/#{id}.png"
  end
  
end
