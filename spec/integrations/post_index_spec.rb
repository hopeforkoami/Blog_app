require'rails_helper'

RSpec.describe 'PostIndex', type: :system do
  describe'post index page' do
    before(:each) do
      @author = User.create(name: 'Koami NOGBEDJI', photo: 'https://linktomyphoto.com/koami_profil', bio: 'my self')
      @post = Post.create(title: 'post title', text: 'this is a text for the post',author_id: @author.id)
      @comment = Comment.create(text: 'this is first a comment', user_id: @author.id, post_id: @post.id)
       Like.create(author_id: @author.id, post_id: @post.id)
      visit user_posts_path(user_id: @author.id)
    end

    it'it should contain the user profil' do
      expect(page).to have_selector('img[src="https://linktomyphoto.com/koami_profil"]') 
    end
    it'it should contain the user name' do
      expect(page).to have_content('Koami NOGBEDJI') 
    end
    it'it should contain the number of the user posts' do
      expect(page).to have_content('Number of posts:
1') 
    end
    it'it should contain the post title' do
      expect(page).to have_content('post title') 
    end
    it 'it should contain the post body' do
      expect(page).to have_content 'this is a text for the post'
    end

    it 'it should contain the first comment on a post' do
      expect(page).to have_content 'this is first a comment'
    end

    it 'it should contain the number of comments a post has.' do
      expect(page).to have_content('Comments: 1')
    end

    it 'it should contain the number of likes a post has.' do
      expect(page).to have_content('Likes: 1')
    end

    it 'shows a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_content('Pagination')
    end
    it 'when user clicks on a post, it redirects to that posts show page' do
      click_link 'post title'
      expect(page).to have_current_path user_post_path(user_id:@author.id, id:@post.id)
    end
  end
end