require 'spec_helper'

describe Card do
  before(:each) do
    @valid_attributes = {
      :deck_id => 1,
      :question => "value for question",
      :answer => "value for answer"
    }
  end

  it "should create a new instance given valid attributes" do
    Card.create!(@valid_attributes)
  end
end
