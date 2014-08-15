class Event < ActiveRecord::Base

	attr_accessor :day, :month, :year

	MONTHS 		= %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
	MONTHSNUM = %w[1   2   3   4   5   6   7   8   9   10  11  12]
	DAYS			= [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]
	
	validates_presence_of :user_id, :what, :when, :where

end

# == Schema Information
#
# Table name: events
#
#  id         :integer         not null, primary key
#	 user_id		:integer
#  when				:date
#  what				:string(255)
#  where			:string(255)
#  remarks    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

