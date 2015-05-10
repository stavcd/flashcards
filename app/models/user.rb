class User < ActiveRecord::Base
  has_many :cards
  authenticates_with_sorcery!
  validates :password, confirmation: true, length: {minimum: 3}, on: [:create, :update], allow_nil: true
  validates :password_confirmation, presence: true, on: [:create, :update], allow_nil: true
  validates :email, :password, presence: true
  validates :email, uniqueness: true
end
