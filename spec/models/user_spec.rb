require 'rails_helper'

RSpec.describe User do

  it { should validate_presence_of :email }

  it { should have_many :cards }

end
