class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  validates :name, presence: true

  def current_deck?
    self == user.current_deck
  end

end
