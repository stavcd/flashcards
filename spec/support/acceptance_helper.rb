module AcceptanceHelper

  def sign_in(user)
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: '12345'
    click_on 'Вход'
  end

  def given_card_for_update_destroy(deck_id)
    sign_in(user)
    visit deck_cards_path(deck_id)
  end

  def given_decks
    sign_in(user)
    visit decks_path
  end
end