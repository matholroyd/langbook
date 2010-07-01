class ChineseCharacter < ActiveRecord::Base
  def self.import_characters
    FasterCSV.foreach('db/static/chinese_characters.txt') do |row|
      DBC.assert(row.length == 4)
      transliteration = row[1].gsub(/\d/, '')
      ChineseCharacter.create! :character => row[0], :transliteration => transliteration, 
        :transliteration_py => row[2], :transliteration_gr => row[3]
    end
  end
end