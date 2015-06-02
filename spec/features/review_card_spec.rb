require 'rails_helper'

feature 'Review Card', 'It should be the ability to check the knowledge Card' do

  given(:user) { create(:user, password: '12345') }
  given!(:card) { user.cards.create(original_text: 'Hello', translated_text: 'Привет', review_date: '01.05.2015') }

  scenario 'enter the correct translation' do
    sign_in(user)
    fill_in 'input_text', with: 'Привет'
    click_on 'Проверить'
    expect(page).to have_content 'Правильный перевод'
  end

  scenario 'enter the incorrect translation' do
    sign_in(user)
    fill_in 'input_text', with: 'Пюратрет'
    click_on 'Проверить'
    expect(page).to have_content 'Неправильно. В слове ..Привет. Вы допустили 4 ошибок'
  end
end