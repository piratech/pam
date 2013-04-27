class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def welcome_email(user,creator,token)
    @user = user.cn
    @url  = "https://ldap.piratech.de/token/#{user.uid}/#{token}"
    @sender = creator.cn
    @username = user.uid
    
    mail(:to => user.mail, :from => creator.mail ,:subject => "Deine Piraten Zugangsdaten")
  end
end
