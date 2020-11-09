require_relative '../rails_helper'

RSpec.feature 'Follow and Unfollow', type: :feature do
  scenario 'user follow and unfollow' do
    user1 = User.new(full_name: 'User One', username: 'userone')
    user1.coverimage.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
    user1.photo.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
    user1.save
    user2 = User.new(full_name: 'User Two', username: 'usertwo')
    user2.coverimage.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
    user2.photo.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
    user2.save
    visit login_path
    expect(page.current_path).to eq login_path
    page.fill_in 'username', with: 'userone'
    click_button 'Login'
    expect(page.current_path).to eq root_path
    have_link 'Home', href: root_path
    have_link 'User two', href: user_path(user2.id)
    click_link 'User two', href: user_path(user2.id)
    expect(page.current_path).to eq user_path(user2.id)
    have_link 'add_circle_outline', href: follow_user_path(user2.id)
    click_link 'add_circle_outline', href: follow_user_path(user2.id)
    expect(page.current_path).to eq user_path(user2.id)
    have_link 'remove_circle', href: unfollow_user_path(user2.id)
    click_link 'remove_circle', href: unfollow_user_path(user2.id)
    expect(page.current_path).to eq user_path(user2.id)
    have_link 'add_circle_outline', href: follow_user_path(user2.id)
    click_link 'add_circle_outline', href: follow_user_path(user2.id)
    expect(page.current_path).to eq user_path(user2.id)
  end
end
