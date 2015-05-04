require 'rails_helper'

feature 'Create Card', %q{'It should
  be able to create Card'} do

  given(:card) { create(:card) }

  before { visit new_card_path }

  scenario 'create card with valid attributes' do
    fill_in 'card_original_text', with: card.original_text
    fill_in 'card_translated_text', with: card.translated_text
    click_on 'Create Card'
    expect(page).to have_content 'Новая карта создана'
  end

  scenario 'create card with invalid attributes' do
    fill_in 'card_original_text', with: ' '
    fill_in 'card_translated_text', with: card.translated_text
    click_on 'Create Card'
    expect(page).to have_content 'Ошибка в создании карты'
  end

  scenario 'create card with equal text' do
    fill_in 'card_original_text', with: 'hello'
    fill_in 'card_translated_text', with: ' HelLo '
    click_on 'Create Card'
    expect(page).to have_content 'Оригинальный текст не должен быть равен тексту перевода'
  end
end
