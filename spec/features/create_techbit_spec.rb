require 'rails_helper'

RSpec.describe 'Create Techbit', type: :feature do
    before :each do
      user = User.new(full_name: 'User Name', username: 'username')
      user.coverimage.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
      user.photo.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
      user.save
  
      techbit = user.techbits.build(bit: 'Test Techbit')
      techbit.save
      visit login_path
      page.fill_in 'username', with: 'username'
      click_button 'Login'
    end
  
    scenario 'Techbit creation', type: :feature do
      expect(page.current_path).to eq root_path
      page.fill_in 'techbit[bit]', with: 'Test Bit'
      click_button 'Create'
      expect(page).to have_text 'Test Bit'
      expect(page).to have_text 'less than a minute'
    end
  end
  