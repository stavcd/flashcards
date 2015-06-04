class UserMailer < ActionMailer::Base
  default from: 'info@stavcdflashcard.com'
  def welcome_email(user)
    @user = user
    @url =  'http://stavcdflashcards.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to StavcdFlashcards')
  end
end
