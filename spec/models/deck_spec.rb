require 'rails_helper'

describe Deck do

  it { should have_many :cards }

  it { should belong_to :user }

  it { should validate_presence_of :name }

  let!(:user) { create(:user) }

  let!(:deck) { user.decks.create(name: 'Test') }

  before { user.current_deck_id = deck.id }

  it 'check deck current ?' do
    expect(deck.current_deck?).to eq true
  end
end
