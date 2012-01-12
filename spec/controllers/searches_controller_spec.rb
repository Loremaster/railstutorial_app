#"NOTICE:  text-search query doesn't contain lexemes: "" " fixed.

require 'spec_helper'

describe SearchesController do
  render_views

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
        @user = test_sign_in( Factory(:user) )
        #controller.stub!(:params).and_return({"q" =>"Minus"})
        get :find_microposts, :q => "Data"                                    #Sending data (by :q => "Text"), because postgre doesn't like empty strings and show warning.
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have right title" do
        response.should have_selector( "title",
                                       :content => "#{@base_title} | Searching microposts")
      end
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
        @user = test_sign_in( Factory(:user) )
        get :find_users, :q => "Another data"                                 #Sending data (by :q => "Text"), because postgre doesn't like empty strings and show warning.
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have right title" do
        response.should have_selector( "title",
                                       :content => "#{@base_title} | Searching users")
      end
    end
  end
end
