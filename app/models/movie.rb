class Movie < ActiveRecord::Base

	attr_accessor :videonum, :user_id, :filename, :video_title, :caption, :videoname
	
	def initialize(user, video)
		@video = video
		@user = user
		@uname = user.uname
		self.user_id = user.id
    length = video.original_filename.length - 5
    self.filename = video.original_filename[0..length]
		@videodir ="#{Rails.root.to_s}/public/videos/#{@uname}"
		Dir.mkdir(@videodir) unless File.directory?(@videodir)
	end
	
	def save_video
		self.videonum = @user.video_number || 0
		self.videonum += 1
		#numstr = videonum.to_s
		#if 		videonum > 999
		#	self.filename = @uname + '_' + numstr
		#elsif videonum > 99
		#	self.filename = @uname + '_0' + numstr
		#elsif videonum > 9
		#	self.filename = @uname + '_00' + numstr
		#else
		#	self.filename = @uname + '_000' + numstr
		#end
		valid_image? and converted?
	end

	private
	
	def valid_image?
		source = File.join("/tmp", @uname)
		unless @video.content_type =~ /^video/
			errors.add_to_base("#{@video.original_filename} is not a recognized format")
			return false
		end
		if @video.size > 100.megabyte
			errors.add_to_base("The size of #{@video.original_filename} is #{@video.size}; the source video should not be bigger than 100 mb")
			return false
		end
		return true
	end
	
	def converted?
		source = File.join('/tmp', @uname)
		File.delete(source) if File.exists?(source)
		File.open(source, "wb") {|f| f.write(@video.read)}
		thumbnail = File.join(@videodir, filename + '.jpg')
		self.videoname = File.join(@videodir, filename + '.flv')
		File.delete(thumbnail) if File.exists?(thumbnail)
		File.delete(videoname) if File.exists?(videoname)
		thumb = system("ffmpeg -i #{source} -ss 9 -vframes 1 -s 60x40 -f image2 #{thumbnail}")
		if File.extname(@video.original_filename) == '.flv'
			system("ffmpeg -i #{source} -vcodec copy -acodec copy #{videoname} &")
		else
			system("ffmpeg -i #{source} -r 40 -s cga -acodec libmp3lame -ar 44100 -vcodec flv #{videoname} &")
		end
		unless thumb
			errors.add_to_base("Upload of #{@video.original_filename} failed; please try again")
			return false
		end
		return true
	end
	
end
