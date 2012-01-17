#require "rspec"
#
#describe "Searches" do
#  before(:each) do
#    user = Factory(:user)
#  end
#
#  describe "for sign in user" do
#    it "should find existing posts" do
#      visit signin_path
#      fill_in :email,    :with => user.email
#      fill_in :password, :with => user.password
#      click_button
#    end
#  end
#
#end