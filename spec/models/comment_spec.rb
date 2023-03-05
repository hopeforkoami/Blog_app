require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'my self') }
  let(:post) do
    Post.create(title: 'post title', text: 'this is a text for the post', comments_counter: 20, likes_counter: 30,
                author_id: user.id)
  end
  subject { Comment.new(text: 'this is a comment', user_id: user.id, post_id: post.id) }

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end
  it 'increments the comments_counter of the associated post after saving' do
    expect { subject.save }.to change { post.reload.comments_counter }.by(1)
  end

  it 'is not valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
end
