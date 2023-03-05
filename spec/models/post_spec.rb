require_relative '../rails_helper'

Rspec.describe Post, type: :model do
  author = User.create(name: 'Koami NOGBEDJI', photo:'https://linktomyphoto.com/koami_profil', bio: 'my self')
  subject do
    Post.new(title: 'post title', text: 'this is a text for the post', comments_counter: 20, likes_counter: 30,
             author: author)
  end

  

end