require 'rails_helper'

RSpec.describe Following, type: :model do
  before :each do
    @first_user = User.new(full_name: 'First User', username: 'First')
    @second_user = User.new(full_name: 'Second User', username: 'Second')
    # file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
    File.open(File.expand_path('spec/test_image.jpg')) do |tstmage|
      @first_user.coverimage.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
      @first_user.photo.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
      @second_user.coverimage.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
      @second_user.photo.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
    end
    @first_user.save
    @second_user.save
  end

 

  it 'creates a valid following' do
    following = Following.new(follower_id: @first_user.id, followed_id: @second_user.id)
    expect(following).to be_valid
  end

  it 'creates a invalid following' do
    following = Following.new(follower_id: '', followed_id: '')
    expect(following).to_not be_valid
  end

  context 'Association tests' do
    it 'belongs to follower' do
      assc = Following.reflect_on_association(:follower)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to followed' do
      assc = Following.reflect_on_association(:followed)
      expect(assc.macro).to eq :belongs_to
    end
  end
end

