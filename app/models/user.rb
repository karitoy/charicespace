require "digest/sha2"

class User < ActiveRecord::Base

  attr_accessor :rememberme, :authorized, :pword_current
	attr_accessor :password
	
	has_one :picture
	has_many :posts
	has_many :videos
	has_many :comments
	
	validates :firstname, :lastname, :presence=>true,	:length=>{within: 2..50}
	validates :email, :presence=>true, 		:confirmation=>true, :uniqueness=>true, :format=>{:with=>/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
	validates :password, :presence=>true, :confirmation=>true, :length=>{:within=>6..20}
	
	before_save :encrypt_password, :downcase_email
	

	ATTRS = 
	{  
     uname: "Username",  
     email: "Email",  
     pword: "Password"  
  }  
  
  def self.human_attribute_name(attr)  
    ATTRS[attr.to_sym] || super  
  end  

  def login!(session)
    session[:user_id] = id
  end

  def self.logout!(session, cookies)
    session[:user_id] = nil
    cookies.delete("authorized")
  end

  def remember?
    self.rememberme == "1"
  end

  def remember!(cookies)
    token = Digest::SHA1.hexdigest("#{uname}:#{pword}")
    self.authorization_token = token
    self.save!
    cookies[:authorized] = { :value=>token, :expires=>10.years.from_now }
    cookies[:rememberme] = { :value=>"1", :expires=>10.years.from_now }
    self.rememberme = "1"
  end

  def capitalize!
		self.firstname.capitalize! if firstname
		self.lastname.capitalize! if lastname
	end  	

  def forget!(cookies)
    cookies.delete("authorized")
    cookies.delete("rememberme")
    self.rememberme = "0"
  end

	def clear_password
		self.password = ''
		self.password_confirmation = ''
	end
	
  def clear_password!
    self.pword = nil
    self.pword_current = nil
    self.pword_confirmation = nil
  end

  def password_errors(params)
    self.pword = params[:user][:pword]
    self.pword_confirmation = params[:user][:pword_confirmation]
    valid?
    errors.add(:pword_current, ": password is incorrect")
  end

	def has_password?(string)
		encrypted_password == encrypt(string)
	end
	
	def self.authenticate(email, pass)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(pass)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	def feed
		Micropost.where('user_id = ?', id)
	end
	
	private
  
  # Generate a unique identifier for a user.
  def unique_identifier
    Digest::SHA1.hexdigest("#{screen_name}:#{password}")
  end
  
	def encrypt_password
		self.salt = make_salt if new_record?
		self.encrypted_password = encrypt(password)
	end
	
	def encrypt(passwd)
		secure_hash("#{salt}--#{passwd}")
	end
	
	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")
	end
	
	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end
	
	def downcase_email
		self.email.downcase!
	end
	
end




# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  firstname           :string(255)
#  lastname            :string(255)
#  email               :string(255)
#  pword               :string(255)
#  avatar              :string(255)
#  video_number        :integer
#  last_comment        :integer
#  last_post           :integer
#  birthday            :string(255)
#  birthcity           :string(255)
#  birthcountry        :string(255)
#  presentcity         :string(255)
#  presentcountry      :string(255)
#  aboutme             :text
#  authorization_token :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

