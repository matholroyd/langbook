namespace :import do
  task :chinese_characters => :environment do
    ChineseCharacter.delete_all
    
    FasterCSV.foreach('db/static/chinese_characters.txt') do |row|
      DBC.assert(row.length == 3)
      ChineseCharacter.create! :character => row[0], :transliteration_gr => row[1], 
        :transliteration_py => row[2]
    end
  end
end