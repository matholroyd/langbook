require 'spec_helper'

describe Entry do
  before :each do
  end
    
  describe 'validations' do
    it 'blueprint should be valid' do
      Entry.make
    end
    
    it 'should have language set' do
      Entry.make.language.should_not be_nil
    end
    
    [:user_id, :standard_form, :language_id, :transliteration, :meaning_language_id].each do |field|
      it "should require #{field}" do
       Entry.make_unsaved(field => nil).should have(1).error_on(field)
      end
    end
  end

  describe Language::German do
    before :each do
      @entry = Entry.make(:language => Language::German)
    end
    
    it 'should auto fillout transliteration' do
      @entry.update_attributes(:standard_form => 'hallo')
      @entry.set_transliteration_via_standard_form
      @entry.transliteration.should == 'hallo'
    end
  end

  describe Language::Chinese do
    before :each do
      @entry = Entry.make(:language => Language::Chinese)
    end
    
    it 'should auto fillout transliteration' do
      @entry.update_attributes(:standard_form => '你')
      @entry.set_transliteration_via_standard_form
      @entry.transliteration.should == 'ni'
      @entry.transliteration_2.should == 'nĭ'
      @entry.transliteration_3.should == 'nii'
    end
  end
  
end
