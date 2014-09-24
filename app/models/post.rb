class Post < ActiveRecord::Base
	belongs_to :user
	
  DB_STRING_MAX_LENGTH = 255
  DB_TEXT_MAX_LENGTH = 25500
  
	validates :blog_title, :blog_text, :user_id, presence: true
	validates :blog_title,	length: {:maximum=>DB_STRING_MAX_LENGTH}
	validates :blog_text,		length: {:maximum=>DB_TEXT_MAX_LENGTH}
	validates :blog_text, uniqueness: true
	
	def duplicate?
		post = Post.find_by_user_id_and_blog_title_and_blog_text(user_id, blog_title, blog_text)
		self.id = post.id unless post.nil?
		!post.nil?
	end
	
	def unique?
		post = Post.find_by_user_id_and_blog_title_and_blog_text(user_id, blog_title, blog_text)
		self.id = post.id unless post.nil?
		post.nil?
	end
end


