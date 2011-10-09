require 'development_mail_interceptor'                                        #We need that to make possible sending mails about registration to myself in DEV mode.

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "is.selenium@gmail.com",
  :password             => "p@$$w0rd_selen!um",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
ActionMailer::Base.register_interceptor( DevelopmentMailInterceptor ) if  Rails.env.development?   #in Development mode all "hello user" letters go to me.