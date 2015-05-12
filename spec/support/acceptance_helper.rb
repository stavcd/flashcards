module AcceptanceHelper

  def sign_in(user)
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 12345
    click_on 'Вход'
  end

  def successful_entry_for_card_creating
    expect(page).to have_content 'Logout'
    visit new_card_path
  end

  def given_card_for_update
    sign_in(user)
    visit cards_path
  end



end