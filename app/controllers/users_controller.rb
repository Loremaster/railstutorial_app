class UsersController < ApplicationController
  
  def show
    @user  = User.find(params[:id])
    @title = @user.name                                                       #in Rails 3 it is not potential problem beacuse of Rails 3.0 all Embedded Ruby text is escaped by default.
  end
  
  def new
    @title = "Sign up"
  end

end
