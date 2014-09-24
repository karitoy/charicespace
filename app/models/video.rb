class Video < ActiveRecord::Base

	belongs_to :user
	has_many :comments

end






# == Schema Information
#
# Table name: videos
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  video_number    :integer         default(1)
#  filename        :string(255)
#  thumbnail       :string(255)
#  video_title     :string(255)
#  caption         :string(255)
#  number_of_views :integer
#  responseto      :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

