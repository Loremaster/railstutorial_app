class UsersController < ApplicationController
  
  def show
    @user  = User.find(params[:id])
    @title = @user.name                                                       #in Rails 3 it is not potential problem beacuse of Rails 3.0 all Embedded Ruby text is escaped by default.
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
        sign_in @user                                                         #Sign user in. We are using Session Helper for that.
        flash[:success] = "Welcome to the Sample App!"                        #Flash message, appear once.
        redirect_to @user
    else
        @user.password = ''                                                   #It doesn't look like it clear password. I still able to see it with rails debug... 
        @title = "Sign up"
        render 'new'
    end
  end

end
