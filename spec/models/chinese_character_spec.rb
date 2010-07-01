require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ChineseCharacter do
  it 'should be automatically filled with data' do
    ChineseCharacter.count.should > 100
  end
end
