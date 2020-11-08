require 'rails_helper'

RSpec.describe Techbit, type: :model do
  context 'Validation tests' do
    subject { Techbit.new }

    it 'is valid with valid attributes' do
      user = User.new(full_name: 'Test User', username: 'testuser')
      user.coverimage.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      user.photo.attach(io: File.open('spec/image.jpg'), filename: 'image.jpg', content_type: 'image/jpg')
      user.save
      subject.bit = 'Test Techbit'
      subject.author = user
      expect(subject).to be_valid
    end

    it 'is not valid without content' do
      expect(subject).to_not be_valid
    end
  end

  context 'Association tests' do
    it 'belongs to user' do
      assc = Techbit.reflect_on_association(:author)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
