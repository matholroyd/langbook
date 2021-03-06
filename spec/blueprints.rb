require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name     { Faker::Name.name }
Sham.email    { Faker::Internet.email }
Sham.title    { Faker::Lorem.sentence }
Sham.body     { Faker::Lorem.paragraph }
Sham.country  { Faker::Address.uk_country }
Sham.subject  { Faker::Lorem.sentence }
Sham.password(:unique => false) { 'secret' }

User.blueprint do 
  email
  password
  password_confirmation { password }
end

Deck.blueprint do
  user
  name { Sham.title }
end

Card.blueprint do
  deck
  question { Sham.body }
  answer { Sham.body }
end

Entry.blueprint do
  user
  standard_form {'你'}
  transliteration { 'ni' }
  language_id { Language::Mandarin.id }
  meaning_language_id { Language::English.id }
end
  
  