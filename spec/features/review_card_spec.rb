require 'rails_helper'

feature 'Review Card', 'It should be the ability to check the knowledge Card' do

  before do
    Card.create(original_text: 'hello', translated_text: 'Привет', review_date: '01.05.2015')
    visit root_path
  end

  scenario 'enter the correct translation' do
    fill_in 'input_text', with: 'Привет'
    click_on 'Проверить'
    expect(page).to have_content 'Правильный перевод'
  end

  scenario 'enter the incorrect translation' do
    fill_in 'input_text', with: 'Приветик'
    click_on 'Проверить'
    expect(page).to have_content 'Неправильный перевод'
  end

end

