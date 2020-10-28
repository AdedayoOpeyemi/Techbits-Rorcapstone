require 'rails_helper'

RSpec.describe Following, type: :model do
  before :each do
    @first_user = User.new(full_name: 'First User', username: 'First')
    @second_user = User.new(full_name: 'Second User', username: 'Second')
    @first_user.coverimage.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
    @first_user.photo.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
    @second_user.coverimage.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
    @second_user.photo.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')

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
