require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  author = User.create(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'my self', posts_counter: 20)
  subject do
    Post.new(title: 'post title', text: 'this is a text for the post', comments_counter: 20, likes_counter: 30,
             author_id: author.id)
  end
  before{ subject.save }

  describe ' GET #index' do
    before(:example) { get user_posts_path(user_id: 3) } 
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end
    it "renders the correct template" do
      expect(response).to render_template(:index)
    end
    it "must include  the page body" do
      expect(response.body).to include("this is the Posts index page.")
    end
  end

  describe ' GET #show' do
    before(:example) { get user_post_path(user_id: 3, id: 3) } 
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end
    it "renders the correct template" do
      expect(response).to render_template(:show)
    end
    it "must include  the page body" do
      expect(response.body).to include("This is the Post show page.")
    end
  end
end
