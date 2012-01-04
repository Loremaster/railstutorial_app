require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")              #error_explanation is CSS shorthand for <div id="error_explanation">...</div>
        end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
    
    describe "sign in/out" do
      
        describe "failure" do
          it "should not sign a user in" do
            visit signin_path
            fill_in :email,    :with => ""
            fill_in :password, :with => ""
            click_button
            response.should have_selector("div.flash.error", :content => "Invalid")
          end
        end

        describe "success" do
          it "should sign a user in and out" do
            user = Factory(:user)
            visit signin_path
            fill_in :email,    :with => user.email
            fill_in :password, :with => user.password
            click_button
            controller.should be_signed_in
            click_link "Sign out"
            controller.should_not be_signed_in
          end
        end
    end 
  end
  
  describe "for sign-in user" do
    it "should have right form of 'Micropost' for 0, 1 and 2 microposts" do
      user = Factory(:user)
         
      visit signin_path
      fill_in :email,    :with => user.email
      fill_in :password, :with => user.password
      click_button 
      visit root_path
            
      num_of_user_posts = user.microposts.count
      response.should have_selector("div.user_info",
                                     :content => num_of_user_posts.to_s + " microposts")
      
      fill_in :micropost_content, :with => "My 1st post!"
      click_button
      num_of_user_posts = user.microposts.count
      response.should have_selector("div.user_info",
                                     :content => num_of_user_posts.to_s + " micropost")
                                     
      fill_in :micropost_content, :with => "My 2nd post!"
      click_button
      num_of_user_posts = user.microposts.count
      response.should have_selector("div.user_info",
                                     :content => num_of_user_posts.to_s + " microposts")
    end  

    it "should have no links to delete message on paseg of other users" do
      first  = Factory(:user, :name => "Bob", :email => "ohno@example.com")
      second = Factory(:user, :name => "Tom", :email => "lost@example.com")
      
      first.microposts.create(:content  => "Test message of first user.")
      second.microposts.create(:content => "Test message of second user.")
             
      visit signin_path
      fill_in :email,    :with => first.email
      fill_in :password, :with => first.password
      click_button
      
      visit user_path( second.id )
  
      response.should_not have_selector("table.microposts", 
                                        :content => "delete")
    end

    describe "notification settings" do
      before(:each) do
        @user_one = Factory( :user, :name  => "Tuomas",
                                    :email => "aim@tuomas.com")
        @user_two = Factory( :user, :name  => "Tarja",
                                    :email => "aim@tarja.com")
      end

      it "should send notification about new follower by default" do
        visit signin_path
        fill_in :email,    :with => @user_one.email
        fill_in :password, :with => @user_one.password
        click_button

        visit user_path( @user_two.id )
        click_button

        ActionMailer::Base.deliveries.last.to.should == [@user_two.email]     #Followed user(num-2) should be notificated.
      end

      it "should deny send notification about new follower if such setiing is off" do

        #First User
        visit signin_path
        fill_in :email,    :with => @user_one.email
        fill_in :password, :with => @user_one.password
        click_button

        visit edit_user_path( @user_one.id )
        fill_in :email,    :with => @user_one.email
        fill_in :password, :with => @user_one.password
        uncheck('user_notification_about_new_followers')                      #User-1 chooses about not confirming him about new followers
        click_button

        visit signout_path

        #Second User
        visit signin_path
        fill_in :email,    :with => @user_two.email
        fill_in :password, :with => @user_two.password
        click_button

        visit user_path( @user_one.id )
        click_button

        response.should_not render_template('user_mailer/new_follower_notification.html.erb')  #if it doesn't render then mail will not send.
      end
    end
  end


  #RSS
  describe "RSS for registered user" do
    before(:each) do
        @user_one = Factory( :user, :name  => "Mike",
                                    :email => "aim@mike.com")
    end

    it "should return an RSS feed" do
        get user_path( @user_one.id ), :format => "rss"
        response.should be_success
        response.should render_template("users/show")
        response.content_type.should eq("application/rss+xml")
    end

    #Not really sure that it is correct but autotest tells me that there is no "users/show.html.erb" or "users/show.rss.builder"
    it "should show rss feed for registered users" do
      visit signin_path
      fill_in :email,    :with => @user_one.email
      fill_in :password, :with => @user_one.password
      click_button

      visit root_path
      fill_in :micropost_content, :with => "My 1st post!"
      click_button

      visit user_path( @user_one.id )
      click_link "Feed"
      response.should render_template('users/show')
    end

    #describe "GET RSS feed for first user" do
#      it "returns an RSS feed" do
#        get "users/1", :format => "rss"
#        response.should be_success
#        response.should render_template("users/show")
#        response.content_type.should eq("application/rss+xml")
#      end
    #end
  end
end


