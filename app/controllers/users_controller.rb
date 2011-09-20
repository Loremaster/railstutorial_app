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
        flash[:success] = "Welcome to the Sample App!"                        #Flash message, appear once.
        redirect_to @user
    else
        @title = "Sign up"
        render 'new'
    end
  end

end
