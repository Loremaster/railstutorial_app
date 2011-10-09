class UserMailer < ActionMailer::Base
  default :from => "from@example.com",
          :charset => "UTF-8"

  def registration_confirmation(user)
    @user = user
    attachments["rails.png"] = File.read("#{Rails.root}/app/assets/images/rails.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
end
