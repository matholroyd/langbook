class Language < LocalRecord
  Language[1, 'Chinese']
  Language[2, 'English']
  Language[3, 'German']
  Language[4, 'Russian']
  
  def transliterate(standard_form)
    standard_form
  end
  
  class << Chinese
    
  end
end