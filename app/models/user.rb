class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :decks, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  belongs_to :current_deck, class_name: 'Deck', foreign_key: 'current_deck_id'
  accepts_nested_attributes_for :authentications
  validates :password, presence: true, confirmation: true, length: {minimum: 3}, on: [:create, :update], allow_nil: true
  validates :password_confirmation, presence: true, on: [:create, :update], allow_nil: true
  validates :email, presence: true, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/}

  def cards_for_review
    if current_deck
      current_deck.cards.for_review
    else
      cards.for_review
    end
  end
end
