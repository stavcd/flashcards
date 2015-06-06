class UserMailer < ActionMailer::Base
  layout 'mailer'
  default from:  ENV['USER_MAILER_DEFAULT']

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome STAVCDFLASHCARDS')
  end
end
