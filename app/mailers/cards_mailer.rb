class CardsMailer < ActionMailer::Base
  default from: 'info@stavcdflashcard.com'

  def pending_cards_notification(user, review_count)
    @user = user
    @review_count = review_count
    @url = 'http://stavcdflahcards.herokuapp.com'
    mail(to: @user.email, subject: 'Пришло время проверить знания')
  end
end
