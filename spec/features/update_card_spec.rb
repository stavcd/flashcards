require 'rails_helper'

feature 'Update Card', %q{There should
 be the ability to edit card} do
  given!(:card) { create(:card) }

  before do
    visit cards_path
    click_on 'Редактировать'
  end

  scenario 'update card with valid attributes' do
    fill_in 'card_original_text', with: 'text'
    fill_in 'card_translated_text', with: 'текст'
    click_on 'Update Card'
    expect(current_path).to eq cards_path
  end

  scenario 'update card with invalid attributes' do
    fill_in 'card_original_text', with: 'text'
    fill_in 'card_translated_text', with: 'text'
    click_on 'Update Card'
    expect(current_path).to eq edit_card_path(card.id)
  end
end