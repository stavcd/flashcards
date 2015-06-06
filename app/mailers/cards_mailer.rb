class CardsMailer < ActionMailer::Base
  layout 'mailer'
  default from: ENV['CARDS_MAILER_DEFAULT_FROM']

  def pending_cards_notification(user, review_count)
    @user = user
    @review_count = review_count
    mail(to: @user.email, subject: 'You have some cards fo review')
  end
end
