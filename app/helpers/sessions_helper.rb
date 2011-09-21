module SessionsHelper
  def sign_in( user )
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]          #Creating secure remember token associated with the User model to be used in place of the user id
    self.current_user = user                                                  #Self is Controller (because of our including Sessions Helper inside of Application Helper)
  end
  
  def current_user=( user )
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]                           #We return [nil,nil] because nil value for the cookie causes test breakage.
    end
end
