class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class =Authentication
  end
  has_many :cards
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  validates :password, confirmation: true, length: {minimum: 3}, on: [:create, :update], allow_nil: true
  validates :password_confirmation, presence: true, on: [:create, :update], allow_nil: true
  validates :email, :password, presence: true
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
end
