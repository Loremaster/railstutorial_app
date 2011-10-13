require "spec_helper"

describe UserMailer do

  before(:each) do
    @address_of_sender = ['from@example.com']
  end

  describe "Letter about registration for new users" do
      let(:user) { mock_model(User, :name  => 'Lucas',
                                    :email => 'lucas@email.com') }
      let(:mail) { UserMailer.registration_confirmation(user).deliver }

      it "should have correct subject form" do
        mail.subject.should == 'Registered'
      end

      it "should have address of receiver" do
        mail.to.should == [ user.email ]
      end

      it "should have correct address of sender" do
        mail.from.should == @address_of_sender
      end

      it "should have name of user inside of letter" do
        mail.body.encoded.should match( user.name )
      end
  end

  describe "Letter about new followers" do
    let(:user2) { mock_model( User, :name => 'John',
                                    :email=> 'john@email.com' ) }
    let(:mail_about_followers) { UserMailer.new_follower_notification( user2 ) }

    it "should have correct subject form" do
      mail_about_followers.subject.should == 'New follower'
    end

    it "should have address of receiver" do
      mail_about_followers.to.should == [ user2.email ]
    end

    it "should have correct address of sender" do
      mail_about_followers.from.should == @address_of_sender
    end

    it "should have name of user inside of letter" do
      mail_about_followers.body.encoded.should match( user2.name )
    end
  end

end
