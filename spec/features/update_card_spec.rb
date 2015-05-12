require 'rails_helper'

feature 'Update Card', %q{There should
 be the ability to edit card} do

  given(:user) { create(:user, password: '12345') }
  given!(:card) { user.cards.create(original_text: 'Hello', translated_text: 'Привет', review_date: DateTime.current) }

  scenario 'update card with valid attributes' do
    given_card_for_update
    click_on 'Редактировать'
    fill_in 'card[original_text]', with: 'text'
    fill_in 'card[translated_text]', with: 'текст'
    click_on 'Update Card'
    expect(current_path).to eq cards_path
  end

  scenario 'update card with invalid attributes' do
    given_card_for_update
    click_on 'Редактировать'
    fill_in 'card[original_text]', with: 'text'
    fill_in 'card[translated_text]', with: 'text'
    click_on 'Update Card'
    expect(current_path).to eq edit_card_path(card.id)
  end
end