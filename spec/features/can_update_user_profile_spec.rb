require 'rails_helper'

feature 'User can show profile' do

  given(:user) { create(:user, password: '12345') }

  scenario 'authenticated user can show profile with valid attributes' do
    sign_in(user)
    visit root_path
    click_on 'Редактировать профиль'
    fill_in 'user[email]', with: '12345@test.com'
    fill_in 'user[password]', with: 555
    fill_in 'user[password_confirmation]', with: 555
    click_button 'Обновить'
    expect(page).to have_content 'Update user successfully'
  end

  scenario 'authenticated user updates profile with invalid attributes' do
    sign_in(user)
    visit root_path
    click_on 'Редактировать профиль'
    fill_in 'user[email]', with: '12345@test.com'
    fill_in 'user[password]', with: 555
    fill_in 'user[password_confirmation]', with: ''
    click_button 'Обновить'
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario 'authenticated user updates profile with short password' do
    sign_in(user)
    visit root_path
    click_on 'Редактировать профиль'
    fill_in 'user[email]', with: '12345@test.com'
    fill_in 'user[password]', with: 55
    fill_in 'user[password_confirmation]', with: '55'
    click_button 'Обновить'
    expect(page).to have_content "Password is too short (minimum is 3 characters)"
  end
end