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
    
    [:user_id, :standard_form, :pronounciation, :language_id].each do |field|
      it "should require #{field}" do
        Entry.make_unsaved(field => nil).should have(1).error_on(field)
      end
    end
  end

end
