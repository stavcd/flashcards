require 'rails_helper'

feature 'User can register', %q{
  To use the site
  the user can register} do


  scenario 'user enters with valid  data' do
    visit root_path
    click_on 'Register'

    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: 12345
    fill_in 'user[password_confirmation]', with: 12345
    click_on 'Регистрация'


    expect(page).to have_content 'User was successfully created'
    expect(current_path).to eq root_path
  end


end
