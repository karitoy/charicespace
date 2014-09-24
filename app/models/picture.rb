class Picture < ActiveRecord::Base

	belongs_to :user
	
	URL_STUB = "/images/avatars"
	#DIRECTORY = File.join("public", "images", "pictures")
	DIRECTORY = "#{Rails.root.to_s}/public/images/avatars"
	
	IMG_SIZE = '"150x100"'
	IMG_RESIZE = '"150x100>"'
	THUMB_SIZE = '"64x50"'
	THUMB_RESIZE = '"64x50>"'

	def initialize(uname, image = nil)
		@image = image
		@uname = uname
		Dir.mkdir(DIRECTORY) unless File.directory?(DIRECTORY)
		#videoDir = "#{Rails.root.to_s}/public/images/#{uname}"
		#Dir.mkdir(videoDir) unless File.directory?(videoDir)
	end
	
	def exists?
		File.exists?(File.join(DIRECTORY, file_name))
	end
	
	alias exist? exists?
	
	def url
		"#{URL_STUB}/#{file_name}"
	end
	
	def thumbnail_url
		"#{URL_STUB}/#{thumbnail_name}"
	end
	
	def save
		valid_file? and successful_conversion?
	end
	
	############################################################# private part
	private 
	#############################################################
	
	def file_name
		"#{@uname}.png"
	end

	def thumbnail_name
		"#{@uname}_thumbnail.png"
	end
		
	def convert
		if ENV["OS"] =~ /Windows/
			"c:\\program files\\ImageMagick-6.3.1-Q16\\convert"
		else
			"/usr/bin/convert"
		end
	end
	
	def valid_file?
		source 		= File.join("/tmp", @uname + "_full_size")
		unless @image.content_type =~ /^image/
			errors.add(:image, "is not a recognized format")
			return false
		end
		if @image.size > 1.megabyte
			errors.add(:image, "can't be bigger than 1 mb")
			return false
		end
		return true
	end
	
	def successful_conversion?
		source 		= File.join("/tmp", 		@uname + "_full_size")
		full_size = File.join(DIRECTORY, 	file_name)
		thumbnail = File.join(DIRECTORY, 	thumbnail_name)
		File.open(source, "wb") {|f| f.write(@image.read)}
		img 	= system("convert -size #{IMG_SIZE} #{source} 	-resize #{IMG_RESIZE} #{full_size}")
		thumb = system("convert -size #{THUMB_SIZE} #{source} -resize #{THUMB_RESIZE} #{thumbnail}")
		File.delete(source) if File.exists?(source)
		unless img and thumb
			errors.add_to_base("File upload failed. Try a different image?")
			return false
		end
		return true
	end
	
	def delete
		[file_name, thumbnail_name].each do |name|
			image = "#{DIRECTORY}/#{name}"
			File.delete(image) if File.exists?(image)
		end
	end
	
	def self.delete_image(image)
		file = 'images/avatars/' + image + '.png'
		thum = 'images/avatars/' + image + '_thumbnail.png'
		File.delete(thum) if File.exists?(thum)
		File.delete(file) if File.exists?(file)
	end
	
end

