require_relative '../rails_helper'

RSpec.feature 'User Login', type: :feature do
  scenario 'Log in and log out' do
    user1 = User.new(full_name: 'User One', username: 'userone')
    user1.coverimage.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
    user1.photo.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
    user1.save

    user2 = User.new(full_name: 'User Two', username: 'usertwo')
    user2.coverimage.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
    user2.photo.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
    user2.save

    visit login_path
    have_link 'Login', href: login_path
    have_link 'Signup', href: signup_path
    click_link 'Signup'
    expect(page.current_path).to eq signup_path
    have_link 'Login', href: login_path
    click_link 'Login'
    expect(page.current_path).to eq login_path
    page.fill_in 'username', with: 'userone'
    click_button 'Login'
    expect(page.current_path).to eq root_path
    have_link 'Home', href: root_path
    have_link 'Profile', href: user_path(user1.id)
    have_link 'Logout', href: logout_path
    have_link 'User two', href: user_path(user2.id)
    have_link 'add_circle_outline', href: follow_user_path(user2.id)
    click_link 'add_circle_outline', href: follow_user_path(user2.id)
    expect(page.current_path).to eq root_path
  end
end