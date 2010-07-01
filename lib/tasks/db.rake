namespace :import do
  task :chinese_characters => :environment do
    ChineseCharacter.delete_all
    ChineseCharacter.import_characters
  end
end