class Language < LocalRecord
  Language[1, 'Chinese']
  Language[2, 'English']
  Language[3, 'German']
  Language[4, 'Russian']
  
  def set_transliterate(entry)
    entry.transliteration = entry.standard_form
  end
  
  class << Chinese
    def set_transliterate(entry)
      cc = ChineseCharacter.find_by_character(entry.standard_form)
      entry.transliteration = cc.transliteration
      entry.transliteration_2 = cc.transliteration_py
      entry.transliteration_3 = cc.transliteration_gr
    end
  end
end