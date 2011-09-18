require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'show'" do
      before(:each) do
        @user = Factory(:user)                                                #Create uers by using factory from spec/factories.rb
      end

      it "should be successful" do
        get :show, :id => @user                                               # :show and 'show' are equal. :id => @use equal :id => @user.id
        response.should be_success
      end

      it "should find the right user" do
        get :show, :id => @user
        assigns(:user).should == @user
      end
      
      it "should have the right title" do
        get :show, :id => @user
        response.should have_selector("title", :content => @user.name)
      end

      it "should include the user's name" do
        get :show, :id => @user
        response.should have_selector("h1", :content => @user.name)
      end

      it "should have a profile image" do
        get :show, :id => @user
        response.should have_selector("h1>img", :class => "gravatar")         #"h1>img" makes sure that the img tag is inside the h1 tag.
                                                                              #:class is option for testing CSS class of the element
      end
  end
    
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end
end