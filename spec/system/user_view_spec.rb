require 'rails_helper'

RSpec.describe 'User view', type:feature do
    before do
        @user1 = User.create(name: 'Koami')
        @user2 = User.create(name: 'Kokou')
        @user3 = User.create(name: 'Alice')
    end
    describe 'Index page' do
        it 'should show all users name' do
            visit '/users'

            expect(page).to have_content(@user1.name)
            expect(page).to have_content(@user2.name)
            expect(page).to have_content(@user3.name)
        end
    end
end