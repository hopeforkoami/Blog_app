require'rails_helper'

RSpec.describe 'User', type: :feature do

    before(:each) do
      @author = User.create(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'developper and author')
      @user1 = User.create(name: 'Enoque Macanda', photo: 'https://linktomyphoto.com/enoque_profil', bio: 'developper and commenter')
      @post = Post.create(title: 'post job', text: 'Job Searching
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed feugiat semper ex, 
        rutrum dictum diam euismod sit amet. Maecenas vitae urna metus. Fusce tempor facilisis scelerisque. Vivamus fermentum, 
        felis eu dapibus consectetur, lectus enim congue est, lacinia eleifend lorem ex nec elit. Suspendisse leo purus, 
        euismod at laoreet id, bibendum sed lorem. Sed egestas, massa a placerat luctus, arcu velit euismod velit, 
        in pharetra felis ipsum ac mi. Phasellus interdum consectetur maximus.',author_id: @author.id)
      Comment.create(text: 'Nice topic, it is very hard to find one', user_id: @user1.id, post_id: @post.id)
      Comment.create(text: 'Thanks, the LORD will favour us', user_id: @author.id, post_id: @post.id)
      Comment.create(text: 'Thanks', user_id: @user1.id, post_id: @post.id)
      Comment.create(text: 'Your are welcome', user_id: @author.id, post_id: @post.id)
      Like.create(author_id: @user1.id, post_id: @post.id)
      visit users_path
    end

    describe 'Index page' do
      it 'should show all users name' do
        expect(page).to have_content(@author.name)
      end
  
      it 'should display image' do
        expect(page).to have_selector("img[src='#{@author.photo}']")
      end
      it'it should contain the number of the user posts' do
        expect(page).to have_content("Number of posts: #{@author.posts.count}") 
      end
      it 'should redirect to user show page' do
        click_link 'Koami NOGBEDJI'
  
        expect(page).to have_current_path "/users/#{@author.id}"
      end
    end

end