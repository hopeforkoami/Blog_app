require'rails_helper'

RSpec.describe 'User', type: :feature do

    before(:each) do
      @user1 = User.create(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'developper and author')
      @author = User.create(name: 'Enoque Macanda', photo: 'https://linktomyphoto.com/enoque_profil', bio: 'developper and commenter')
      @post = Post.create(title: 'post job', text: 'Job Searching
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed feugiat semper ex, 
        rutrum dictum diam euismod sit amet. Maecenas vitae urna metus. Fusce tempor facilisis scelerisque. Vivamus fermentum, 
        felis eu dapibus consectetur, lectus enim congue est, lacinia eleifend lorem ex nec elit. Suspendisse leo purus, 
        euismod at laoreet id, bibendum sed lorem. Sed egestas, massa a placerat luctus, arcu velit euismod velit, 
        in pharetra felis ipsum ac mi. Phasellus interdum consectetur maximus.',author_id: @author.id)
      @post2 = Post.create(title: 'post #2', text: 'Job Searching
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed feugiat semper ex, 
        rutrum dictum diam euismod sit amet. Maecenas vitae urna metus. Fusce tempor facilisis scelerisque. Vivamus fermentum, 
        felis eu dapibus consectetur, lectus enim congue est, lacinia eleifend lorem ex nec elit. Suspendisse leo purus, 
        euismod at laoreet id, bibendum sed lorem. Sed egestas, massa a placerat luctus, arcu velit euismod velit, 
        in pharetra felis ipsum ac mi. Phasellus interdum consectetur maximus.',author_id: @author.id)
      @post3 = Post.create(title: 'post #3', text: 'Job Searching
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed feugiat semper ex, 
        rutrum dictum diam euismod sit amet. Maecenas vitae urna metus. Fusce tempor facilisis scelerisque. Vivamus fermentum, 
        felis eu dapibus consectetur, lectus enim congue est, lacinia eleifend lorem ex nec elit. Suspendisse leo purus, 
        euismod at laoreet id, bibendum sed lorem. Sed egestas, massa a placerat luctus, arcu velit euismod velit, 
        in pharetra felis ipsum ac mi. Phasellus interdum consectetur maximus.',author_id: @author.id)
      @post4 = Post.create(title: 'post #4', text: 'Job Searching
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
        click_link 'Enoque Macanda'
  
        expect(page).to have_current_path "/users/#{@author.id}"
      end
    end

    describe 'Show page' do
      before(:each) do
        visit "/users/#{@author.id}"
      end
  
      it 'should show users profile pic' do
        expect(page).to have_selector("img[src='#{@author.photo}']")
      end
  
      it 'should show users name' do
        expect(page).to have_content(@author.name)
      end
  
      it 'should display the number of posts' do
        expect(page).to have_content("Number of posts: #{@author.posts.count}")
      end
  
      it 'should display user bio' do
        expect(page).to have_content(@author.bio)
      end
  
      it 'should display all users posts when clicking See all posts' do
        visit "/users/#{@author.id}/posts"
  
        expect(page).to have_content(@post.title)
        expect(page).to have_content(@post2.title)
        expect(page).to have_content(@post3.title)
        expect(page).to have_content(@post4.title)
      end
  
      it 'should redirect to clicked post' do
        click_link 'post #3'
  
        expect(page).to have_current_path("/users/#{@author.id}/posts/#{@post3.id}")
      end
  
      it 'should redirect to users posts index page' do
        click_link 'See all posts'
  
        expect(page).to have_current_path("/users/#{@author.id}/posts")
      end
    end

end