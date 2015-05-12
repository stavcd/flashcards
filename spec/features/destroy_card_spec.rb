require 'rails_helper'

feature 'Delete Card', 'possible remove the card' do

  given(:user) { create(:user, password: '12345') }
  given!(:card) { user.cards.create(original_text: 'Hello', translated_text: 'Привет',review_date: DateTime.current) }

  scenario 'delete card' do
    sign_in(user)
    visit cards_path
    click_on 'Удалить'
    expect(current_path).to eq cards_path
    expect(page).to_not have_content 'Удалить'
  end
end
