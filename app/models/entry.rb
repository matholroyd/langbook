class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  
  validates_presence_of :user_id, :standard_form, :pronounciation, :language_id
end
