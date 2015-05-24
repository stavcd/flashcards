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

  given(:user) { create(:user) }
  scenario 'the user has entered a an already existing email' do
    visit root_path
    click_on 'Register'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 12345
    fill_in 'user[password_confirmation]', with: 12345
    click_on 'Регистрация'
    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'the user has entered invalid email' do
    visit root_path
    click_on 'Register'
    fill_in 'user[email]', with: '111'
    fill_in 'user[password]', with: 12345
    fill_in 'user[password_confirmation]', with: 12345
    click_on 'Регистрация'
    expect(page).to have_content 'Email is invalid'
  end

  scenario 'the user has entered blank password' do
    visit root_path
    click_on 'Register'
    fill_in 'user[email]', with: "1@1.com"
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_on 'Регистрация'
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'the user has entered blank password' do
    visit root_path
    click_on 'Register'
    fill_in 'user[email]', with: '"1@1.com"'
    fill_in 'user[password]', with: '1111'
    fill_in 'user[password_confirmation]', with: ''
    click_on 'Регистрация'
    expect(page).to have_content "Password confirmation can't be blank"
  end
end






