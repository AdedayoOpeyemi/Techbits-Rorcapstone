require 'rails_helper'

# require_relative '../rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'invalid if full name not present' do
      user = User.new(full_name: '', username: 'testuser')
      user.photo.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      user.coverimage.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      expect(user.valid?).to be(false)
    end
    it 'invalid if username not present' do
      user = User.new(full_name: 'Test User', username: '')
      user.photo.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      user.coverimage.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      expect(user.valid?).to be(false)
    end
    it 'invalid if photo is not present' do
      user = User.new(full_name: 'Test User', username: 'testuser')
      user.coverimage.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      expect(user.valid?).to be(false)
    end
    it 'invalid if coverimage not present' do
      user = User.new(full_name: 'Test User', username: 'testuser')
      user.photo.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      expect(user.valid?).to be(false)
    end
    it 'validates attributes - valid' do
      user = User.new(full_name: 'Test User', username: 'testuser')
      user.photo.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      user.coverimage.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      expect(user.valid?).to be(true)
    end
  end

  context 'Association tests' do
    it 'has many techbits' do
      assc = User.reflect_on_association(:techbits)
      expect(assc.macro).to eq :has_many
    end

    it 'has many techbits' do
      assc = User.reflect_on_association(:techbits)
      expect(assc.macro).not_to eq :has_one
    end

    it 'has many followed users' do
      assc = User.reflect_on_association(:followed_users)
      expect(assc.macro).to eq :has_many
    end

    it 'has many followed users' do
      assc = User.reflect_on_association(:followed_users)
      expect(assc.macro).not_to eq :has_one
    end

    it 'has many followers' do
      assc = User.reflect_on_association(:following_users)
      expect(assc.macro).to eq :has_many
    end

    it 'has many followers' do
      assc = User.reflect_on_association(:following_users)
      expect(assc.macro).not_to eq :has_one
    end
  end
end
