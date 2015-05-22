require 'rails_helper'

feature 'Update Card', %q{There should
 be the ability to edit card} do

  given(:user) { create(:user) }
  given(:deck) { user.decks.create(name: 'Test') }
  given!(:card) { deck.cards.create(original_text: 'Hello', translated_text: 'Привет',
                                    review_date: DateTime.current, user_id: user.id) }

  scenario 'update card with valid attributes' do
    given_card_for_update_destroy(deck.id)
    click_on 'Редактировать'
    fill_in 'card[original_text]', with: 'text'
    fill_in 'card[translated_text]', with: 'текст'
    click_on 'Update Card'
    expect(current_path).to eq deck_cards_path(deck.id)
  end

  scenario 'update card with invalid attributes' do
    given_card_for_update_destroy(deck.id)
    click_on 'Редактировать'
    fill_in 'card[original_text]', with: 'text'
    fill_in 'card[translated_text]', with: 'text'
    click_on 'Update Card'
    expect(current_path).to eq card_path(card)
  end
end