class CardsMailer < ActionMailer::Base
  layout 'mailer'
  default from: Rails.application.secrets.cards_mailer_default

  def pending_cards_notification(user)
    @user = user
    @review_count = @user.cards.for_review.size
    mail(to: @user.email, subject: 'You have some cards fo review')
  end
end