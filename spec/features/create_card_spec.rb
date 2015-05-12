require 'rails_helper'


feature 'Create Card', %q{' It should
  be able to create Card'} do

  given(:user) { create(:user, password: '12345') }
  given(:card) { user.cards.new(original_text: 'Hello', translated_text: 'Привет') }
  scenario 'authenticated user create card with valid attributes' do
    sign_in(user)
    successful_entry_for_card_creating
    fill_in 'card[original_text]', with: 'Hello'
    fill_in 'card[translated_text]', with: 'Привет'
    click_on 'Create Card'
    expect(page).to have_content 'Новая карта создана'
  end

  scenario 'create card with invalid attributes' do
    sign_in(user)
    successful_entry_for_card_creating
    fill_in 'card[original_text]', with: ' '
    puts card.inspect
    fill_in 'card[translated_text]', with: card.translated_text
    click_on 'Create Card'
    expect(page).to have_content "Original text can't be blank"
  end

  scenario 'create card with equal text' do
    sign_in(user)
    successful_entry_for_card_creating
    fill_in 'card[original_text]', with: 'hello'
    fill_in 'card[translated_text]', with: ' HelLo '
    click_on 'Create Card'
    expect(page).to have_content 'Оригинальный текст не должен быть равен тексту перевода'
  end

end
