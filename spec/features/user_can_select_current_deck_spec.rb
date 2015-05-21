require 'rails_helper'

feature 'Select current deck', %q{
'Authenticated user can
 select current deck '} do

  given(:user) { create(:user) }
  given!(:deck) { user.decks.create(name: 'Test') }

  scenario 'select current deck' do
    sign_in(user)
    visit decks_path(deck.id)
    click_on 'Сделать текущей колодой'
    within '.alert-warning' do
      expect(page).to have_content 'Текущая колода'
    end
    expect(page).to_not have_content 'Сделать текущей колодой'
  end
end