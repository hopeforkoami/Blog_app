require'rails_helper'

RSpec.describe 'PostIndex', type: :feature do
  describe'post show page' do
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
      visit user_posts_path(user_id: @author.id)
    end

    it 'should contain the post title' do
      expect(page).to have_content('post job')
    end

    it 'should contain the post author' do
      expect(page).to have_content('Koami NOGBEDJI')
    end

    it 'should contain the comments counter' do
      expect(page).to have_content('Comments: 4')
    end

    it 'should contain the likes counter' do
      expect(page).to have_content('Likes: 1')
    end

    it 'should contain the post body' do
      expect(page).to have_content('Job Searching')
    end

    it 'should contain the user name of each commentor' do
      expect(page).to have_content('Enoque Macanda')
    end
    it 'should contain the comment text' do
      visit user_post_path(@user, @post.id)
      expect(page).to have_content('Nice topic, it is very hard to find one')
      expect(page).to have_content('Thanks, the LORD will favour us')
      expect(page).to have_content('Thanks')
      expect(page).to have_content('Your are welcome')
    end

  end
end