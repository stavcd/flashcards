class UserMailer < ActionMailer::Base
  layout 'mailer'
  default from: Rails.application.secrets.user_mailer_default

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome STAVCDFLASHCARDS')
  end
end
