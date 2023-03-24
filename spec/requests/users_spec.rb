require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  
  before(:each) do
    @author = User.create(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'my self',posts_counter: 20)
  end

  describe ' GET #index' do
    before(:example) { get users_path } # get(:index)
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(200)
    end
    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end
    it 'must include  the page body' do
      expect(response.body).to include('Koami NOGBEDJI')
    end
  end

  describe ' GET #show' do
    before(:example) { get user_path(id: @author.id) } # get(:show)
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end
    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end
    it 'must include  the page body' do
      expect(response.body).to include('Koami NOGBEDJI')
    end
  end
end
