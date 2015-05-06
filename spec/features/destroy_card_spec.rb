require 'rails_helper'

feature 'Delete Card', 'possible remove the card' do

  given!(:card) { create(:card) }

  scenario 'delete card' do
    visit cards_path
    click_on 'Удалить'
    expect(current_path).to eq cards_path
    expect(page).to_not have_content 'Удалить'
  end
end
