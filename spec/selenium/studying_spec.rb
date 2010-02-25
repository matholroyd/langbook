require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Studying integration' do

  attr_reader :browser
 
  before(:all) do 
    @browser = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*firefox",
      :url => "http://langbook.test/",
      :timeout_in_second => 60

    @browser.execution_delay = 0
    @browser.execution_delay = 200
 
    User.destroy_all
    @user = User.make(:email => 'test@test.com')
  end
 
  before(:each) do
    @browser.start_new_browser_session 
    @browser.highlight_located_element = true 
  end

  append_after(:each) do 
    @browser.close_current_browser_session 
  end 

  it "should show the first card" do    
    browser.open "/"  

    browser.click "link=log in", :wait_for => :page
    browser.type "user_session_email", @user.email 
    browser.type "user_session_password", "secret"
    browser.click "user_session_submit", :wait_for => :page

    browser.click "link=study", :wait_for => :page

    browser.element?('id=thespinner').should == true
    browser.visible?('id=thespinner').should == true

    browser.element?('css=.flash-card').should == true
    browser.visible?('css=.flash-card').should == false

    browser.wait_for :wait_for => :visible, :element => 'css=.flash-card'
    
    # browser.wait_for_

    # browser.click "link=Show answer"
    # browser.is_text_present("1234").should be_true
    # browser.click "link=4"
    # 
    # browser.click "link=log out", :wait_for => :page
  end
end
