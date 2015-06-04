class CardsMailer < ActionMailer::Base
  default from: 'info@stavcdflashcard.com'

  def pending_cards_notification(user, review_count)
    @user = user
    @review_count = review_count
    mail(to: @user.email, subject: 'Пришло время проверить знания')
  end
end
