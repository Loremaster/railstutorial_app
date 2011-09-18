
# Created by 'bundle exec annotate --position before'
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :name, :email, :password, :password_confirmation
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i                          #Regex to check mail.
  
  validates :name,  :presence   => true,
                    :length     => { :maximum => 50 }
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }               #Warning! Method :uniqueness doesnt't guarantee uniqueness!
                    
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,                                 #I really don't understand how rails understsnds to copmare password and his conformation.
                       :length       => { :within => 6..40 } 
                       
  before_save :encrypt_password                                               #This stuff calls "callback". We register variable by sending him to "before_save" 
                                                                              #Then we create method with such name.
                                                                              #Active Record will call this method before saving record (in db)
  
  # Return true if the user's password matches the submitted password.
  def has_password?( submitted_password )
    encrypted_password == encrypt( submitted_password )  
  end
    
  def self.authenticate( email, submitted_password )                          #Here "self" means class User.
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
    
  private 
    def encrypt_password
      self.salt = make_salt if new_record?                                    #Here self means user, object of User's class.
      self.encrypted_password = encrypt( password )                           #password == :password?
    end

    def encrypt( string )
      secure_hash("#{salt}--#{string}")                                                                 
    end 
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end                
end
