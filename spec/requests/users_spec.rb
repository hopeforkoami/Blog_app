require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  subject { User.new(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'my self', posts_counter: 20) }

  before{ subject.save }

  describe ' GEt #index' do
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
end
