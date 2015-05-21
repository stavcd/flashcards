require 'rails_helper'

feature 'User can create, update, destroy deck' do

  given(:user) { create(:user) }
  given!(:deck) { user.decks.create(name: 'Test') }

  scenario 'Create deck' do
    sign_in(user)
    visit new_deck_path
    fill_in 'deck[name]', with: 'test'
    click_on 'Create Deck'
    expect(current_path).to eq decks_path
    expect(page).to have_content 'Deck was successfully created.'
  end

  scenario 'Create deck with blank name' do
    sign_in(user)
    visit new_deck_path
    fill_in 'deck[name]', with: ''
    click_on 'Create Deck'
    expect(page).to have_content "Name can't be blank"
  end

  scenario 'User can destroy deck' do
    given_decks
    click_on 'Удалить'
    expect(page).to_not have_content 'Удалить'
  end

  scenario 'User can update deck name' do
    given_decks
    click_on 'Редактировать'
    fill_in 'deck[name]', with: 'test111'
    click_on 'Update Deck'
    expect(current_path).to eq decks_path
  end

  scenario 'User can update deck with blank name' do
    given_decks
    click_on 'Редактировать'
    fill_in 'deck[name]', with: ''
    click_on 'Update Deck'
    expect(current_path).to eq decks_path
    expect(page).to have_content 'Ошибка обновления'
  end
end

