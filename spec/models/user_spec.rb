require_relative '../rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'my self') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should have valid value' do
    expect(subject.name).to eql 'Koami NOGBEDJI'
  end

  it 'photo should have valid value' do
    expect(subject.photo).to eql 'https://linktomyphoto.com/koami_profil'
  end

  it 'should have posts counter greater than or euqal to 0' do
    subject.posts_counter = 0
    expect(subject).to be_valid
  end

  it 'posts_counter must not be less than 1' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should return 3 recent posts' do
    expect(subject.recent_post).to eq(subject.posts.order(created_at: :desc).limit(3))
  end
end
