class UsersController < ApplicationController
  before_filter :authenticate, :except => [ :show, :new, :create ]            #calls authenticate before calling params
  before_filter :correct_user, :only   => [ :edit, :update]
  before_filter :admin_user,   :only   =>   :destroy
  
  def index
    @title = "All users"
    @users = User.paginate( :page => params[:page] )
  end

  def show
    @user  = User.find( params[:id] )
    @title = @user.name                                                       #in Rails 3 it is not potential problem because of Rails 3.0 all Embedded Ruby text is escaped by default.
    @microposts = @user.microposts.paginate( :page => params[:page] )

    #Looks like we don't need to use this block in Rails 3.1.0

    #RENDER: HTML
    #        RSS
    #respond_to do |format|
#      format.html
#      format.rss { render :layout => false }                                  #index.rss.builder is by default, so FALSE lets us change it.
#    end
  end
  
  def new
    if not signed_in? 
      @user = User.new
      @title = "Sign up"
    else
      redirect_to users_path
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def create
   if not signed_in? 
     @user = User.new(params[:user])
        if @user.save
            sign_in @user                                                     #Sign user in. We use Session Helper for that.
            flash[:success] = "Welcome to the Sample App!"                    #Flash message, appear once.
            UserMailer.registration_confirmation( @user ).deliver             #Sending message for new users.
            redirect_to @user
        else
            @user.password = ''                                               #It doesn't look like it clear password. I still able to see it with rails debug...
            @title = "Sign up"
            render 'new'
        end
   else
     redirect_to users_path
   end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    user_to_delete = User.find( params[:id] )
    if ( current_user.id != user_to_delete.id )  
      user_to_delete.destroy
      flash[:success] = "User destroyed."
    else
      flash[:error] = "You can't delete yourself."
    end
    
    redirect_to users_path                                                    #it is important to use this in both cases 
  end
  
  private
    def correct_user
      @user = User.find( params[:id] )
      redirect_to( root_path ) unless current_user?( @user )
    end
    
    def admin_user
      redirect_to( root_path ) unless current_user.admin?
    end
end
