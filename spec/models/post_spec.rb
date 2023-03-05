require_relative '../rails_helper'

RSpec.describe Post, type: :model do
  author = User.create(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'my self')
  subject do
    Post.new(title: 'post title', text: 'this is a text for the post', comments_counter: 20, likes_counter: 30,
             author_id: author.id)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not be too long' do
    subject.title = 't' * 300
    expect(subject).to_not be_valid
  end

  it 'title should be between 3 and 250 words' do
    subject.title = 't' * 5
    expect(subject).to be_valid
  end

  it 'title should not be empty' do
    subject.title = ' '
    expect(subject).to_not be_valid
  end

  it 'title should have valid value' do
    expect(subject.title).to eql 'post title'
  end

  it 'comments_counter must be integer' do
    subject.comments_counter = 12
    expect(subject).to be_valid
  end

  it 'comments_counter should have valid value' do
    subject.comments_counter = 12.2
    expect(subject).to_not be_valid
  end

  it 'comments_counter must not be less than 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter must be integer' do
    subject.likes_counter = 12
    expect(subject).to be_valid
  end

  it 'likes_counter should have valid value' do
    subject.likes_counter = 12.2
    expect(subject).to_not be_valid
  end

  it 'likes_counter must not be less than 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should return 5 recent comments' do
    expect(subject.recent_comments).to eq(subject.comments.order(created_at: :desc).limit(5))
  end
end
