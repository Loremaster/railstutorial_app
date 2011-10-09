require "spec_helper"

describe UserMailer do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "Letter about registration for new users" do
      let(:user) { mock_model(User, :name => 'Lucas', :email => 'lucas@email.com') }   #WHAT is that?
      let(:mail) { UserMailer.registration_confirmation(user).deliver }                #    and that?

      it "should have correct subject form" do
        mail.subject.should == 'Registered'
      end

      it "should have address of receiver" do
        mail.to.should == [ user.email ]
      end

      it "should have correct address of sender" do
        mail.from.should == ['from@example.com']
      end

      it "should have name of user inside of letter" do
        mail.body.encoded.should match( user.name )
      end
  end

end
