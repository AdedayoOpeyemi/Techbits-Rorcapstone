require_relative '../rails_helper'
RSpec.feature 'User Login', type: :feature do
  scenario 'failed Login without username' do
    visit login_path
    expect(page.current_path).to eq login_path
    page.fill_in 'username', with: 'absent'
    click_button 'Login'
    expect(page.current_path).to eq login_path
    have_link 'Signup', href: signup_path
    expect(page).to have_text 'User not found'
  end

  scenario 'failed Login without username' do
    visit login_path
    expect(page.current_path).to eq login_path
    click_button 'Login'
    expect(page.current_path).to eq login_path
    have_link 'Signup', href: signup_path
    expect(page).to have_text 'User not found'
  end
end
