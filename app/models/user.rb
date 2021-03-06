class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :decks, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  belongs_to :current_deck, class_name: 'Deck', foreign_key: 'current_deck_id'
  accepts_nested_attributes_for :authentications
  validates :password, presence: true, confirmation: true, length:
                         {minimum: 3}, allow_nil: true
  validates :password_confirmation, presence: true, allow_nil: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/},
            unless: :has_authentications?

  def self.review_notification
    User.joins(:cards).where('review_date > current_date').find_each do |user|
      CardsMailer.
          pending_cards_notification(user).deliver_now
    end
  end

  def cards_for_review
    if current_deck
      current_deck.cards.for_review
    else
      cards.for_review
    end
  end

  def has_authentications?
    !email.blank? && authentications.present?
  end
end