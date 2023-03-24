require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  
  before(:each) do
    @author = User.create(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'my self',                       posts_counter: 20)
    @post = Post.create(title: 'post title', text: 'this is a text for the post',author_id: @author.id)
    get user_posts_path(user_id: @author.id)
  end

  describe ' GET #index' do
    #before(:example) { get user_posts_path(user_id: author.id) }
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end
    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end
    it 'must include  the page body' do
      expect(response.body).to include('this is a text for the post')
    end
  end

  describe ' GET #show' do
    before(:example) { get user_post_path(user_id: @author.id, id: @post.id) }
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end
    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end
    it 'must include  the page body' do
      expect(response.body).to include('this is a text for the post')
    end
  end
end
