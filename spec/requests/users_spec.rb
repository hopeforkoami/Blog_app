require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  subject { User.new(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'my self', posts_counter: 20) }

  before{ subject.save }

  describe ' GET #index' do
    before(:example) { get users_path } # get(:index)
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(200)
    end
    it "renders the correct template" do
      expect(response).to render_template(:index)
    end
    it "must include  the page body" do
      expect(response.body).to include("This is the Users index page.")
    end
  end

  describe ' GET #show' do
    before(:example) { get user_path(id: 3) } # get(:show)
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end
    it "renders the correct template" do
      expect(response).to render_template(:show)
    end
    it "must include  the page body" do
      expect(response.body).to include("this is the User show page.")
    end
  end
end
