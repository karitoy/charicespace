class Micropost < ActiveRecord::Base

	attr_accessible :content
	
	belongs_to :user 
	
	validates :content, :presence=>true, :length=>{:maximum=>140}
	validates :user_id, :presence=>true
	
	default_scope :order=>'microposts.created_at DESC'
	
end

# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

