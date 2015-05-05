require 'rails_helper'

feature 'Review Card', 'It should be the ability to check the knowledge Card' do

  before do
    Card.create(original_text: 'hello', translated_text: 'Привет', review_date: '01.05.2015')
  end

  scenario 'enter the correct translation' do
    visit root_path
    fill_in 'input_text', with: 'Привет'
    click_on 'Проверить'
    expect(page).to have_content 'Правильный перевод'
  end


end

