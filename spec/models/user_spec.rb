require 'rails_helper'

describe User do

  it { should have_many :cards }

  it { should have_many :authentications }

  it { should accept_nested_attributes_for :authentications }

  # it { should validate_presence_of :password_confirmation }
  #
  # it { should validate_presence_of :password }

  it { should validate_confirmation_of :password }

  it { should validate_length_of(:password).is_at_least(3) }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of :email }

  it { should allow_value('user@example.com').for(:email) }

end
