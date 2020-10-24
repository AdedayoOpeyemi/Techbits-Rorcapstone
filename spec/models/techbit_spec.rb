require 'rails_helper'

RSpec.describe Techbit, type: :model do
  context 'Validation tests' do
    subject { Techbit.new }
    # let(:test_user) { User.new(full_name: 'Test User', username: 'testuser') }

    it 'is valid with valid attributes' do
      test_user = User.new(full_name: 'Test User', username: 'testuser')
      test_user.coverimage.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
      test_user.photo.attach(io: File.open('spec/test_image.jpg'), filename: 'test_image.png', content_type: 'image/png')
      test_user.save
      subject.bit = 'Test Techbit'
      
      subject.author = test_user
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
