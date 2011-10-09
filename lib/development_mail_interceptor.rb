class DevelopmentMailInterceptor                                              #Deliver message to myself
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "is.selenium@gmail.com"                                      #To webmaster's mail
  end
end