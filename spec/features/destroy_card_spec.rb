require 'rails_helper'

feature 'Delete Card', 'possible remove the card' do

  given(:user) { create(:user) }
  given(:deck) { user.decks.create(name: 'Test') }
  given!(:card) { deck.cards.create(original_text: 'Hello', translated_text: 'Привет',
                                    review_date: DateTime.current, user_id: user.id) }

  scenario 'delete card' do
    given_card_for_update_destroy(deck.id)
    click_on 'Удалить'
    expect(current_path).to eq deck_cards_path(deck.id)
    expect(page).to_not have_content 'Удалить'
  end
end