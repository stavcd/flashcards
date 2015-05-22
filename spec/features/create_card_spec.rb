require 'rails_helper'


feature 'Create Card', %q{' It should
  be able to create Card'} do


  given(:user) { create(:user) }
  given(:deck) { user.decks.create(name: 'Test') }
  given(:card) { deck.cards.new(original_text: 'Hello', translated_text: 'Привет') }

  scenario 'authenticated user create card with valid attributes' do
    sign_in(user)
    visit new_card_path(deck.id)
    fill_in 'card[original_text]', with: 'Hello'
    fill_in 'card[translated_text]', with: 'Привет'
    click_on 'Create Card'
    expect(page).to have_content 'Новая карта успешно создана'
  end

  scenario 'create card with invalid attributes' do
    sign_in(user)
    visit new_card_path(deck.id)
    fill_in 'card[original_text]', with: ' '
    fill_in 'card[translated_text]', with: card.translated_text
    click_on 'Create Card'
    expect(page).to have_content "Original text can't be blank"
  end

  scenario 'create card with equal text' do
    sign_in(user)
    visit new_card_path(deck.id)
    fill_in 'card[original_text]', with: 'hello'
    fill_in 'card[translated_text]', with: ' HelLo '
    click_on 'Create Card'
    expect(page).to have_content 'Оригинальный текст не должен быть равен тексту перевода'
  end
end
