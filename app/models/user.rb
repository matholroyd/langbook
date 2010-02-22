class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :decks
  has_many :cards, :through => :decks
end
