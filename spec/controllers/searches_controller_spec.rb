#Fixed "NOTICE:  text-search query doesn't contain lexemes: "" ".

require 'spec_helper'
require 'thinking_sphinx/test'

describe SearchesController do
  render_views

  #Start search server in test mode
  before(:all) do
      ThinkingSphinx::Test.init
      ThinkingSphinx::Test.start
  end

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
    
  describe "GET 'finding_microposts'" do
    describe "when not signed in" do
      before(:each) do
        get :find_microposts
      end

      it "should not be successful" do
        response.should_not be_success
      end

      it "should not have 'searching microposts' title" do
        response.should_not have_selector( "title",
                                           :content => "#{@base_title} | Searching microposts")
      end
    end
    
    describe "when signed in" do

      before(:each) do
#        RSpec.configure do |config|
#          config.use_transactional_fixtures = false
#        end

        @user = test_sign_in( Factory( :user ) )
        @micropost = Factory( :micropost,
                              :user => @user,
                              :content => "Test message of user")
        ThinkingSphinx::Test.index
        get :find_microposts, :q => @micropost.content                        #Sending data (by :q => "Text"), because postgre doesn't like empty strings and show warning.

#        RSpec.configure do |config|
#          config.use_transactional_fixtures = true
#        end
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have right title" do
        response.should have_selector( "title",
                                       :content => "#{@base_title} | Searching microposts")
      end

#      it "should find micropost of user" do
#        response.should have_selector( "table.microposts",
#                                       :content => @micropost.content)
#      end
    end
  end

  describe "GET 'find_users'" do
    describe "when not signed in" do
      before(:each) do
        get :find_users
      end

      it "should not be successful" do
        response.should_not be_success
      end

      it "should not have 'searching microposts' title" do
        response.should_not have_selector( "title",
                                           :content => "#{@base_title} | Searching microposts")
      end
    end

    describe "when signed in" do
      before(:each) do
        @user = test_sign_in( Factory( :user,
                                       :name => "Bob",
                                       :email => "bob@users.com") )
        ThinkingSphinx::Test.index
        get :find_users, :q => "Bob"                                          #Sending data (by :q => "Your Data"), because postgre doesn't like empty strings and show warning.
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have right title" do
        response.should have_selector( "title",
                                       :content => "#{@base_title} | Searching users")
      end

#      it "should find current user" do
#        response.should have_selector( "ul.users",
#                                       :content => @user.name )
#      end
    end
  end
  
  #Stop search server in test mode
  after(:all) do
      ThinkingSphinx::Test.stop
  end
end