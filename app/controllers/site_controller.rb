class SiteController < ApplicationController
  def index
  	@title = "The Charicematic phenomenon"
  	@videos = Video.order("created_at desc")
  end

  def who
  	@title = "Charice who?"
  	@videos = Video.order("created_at desc")
  end

  def bio
  	@title = "Charice's life story"
  	@videos = Video.order("created_at desc")
  end

  def events
  	@title = "Charice's schedule of appearances and events"
  	@events = Event.order("created_at desc")
  	@videos = Video.order("created_at desc")
  end

  def blogs
  	@title = "Visitors' blogs"
  	#@blogs = Blog.all
  	@posts = Post.order("created_at desc")
  	@videos = Video.order("created_at desc")
		@users = User.paginate :page=>params[:page], :per_page=>5, :conditions => ["last_post > 0"], :order=>"created_at desc"
  end

	def playlists
		@title = "Available playlists"
  	@videos = Video.order("created_at desc")
	end
	
  def register
    @title = "Register for full access"
  	@videos = Video.order("created_at desc")
    @countries = Country.order("country")
    @user = User.new
    if request.post? and params[:user]
  		image = params[:user][:avatar]
      @user = User.new(params[:user])
  		unless image.nil? or image.size == 0
				@avatar = Picture.new(@user.uname, image)
				unless @avatar.save
					flash[:notice] ="The picture was not uploaded"
				end
			end
      @user.avatar = @avatar.url unless @avatar.nil?
      @user.capitalize!
      if @user.save
        @user.login!(session)
        redirect_to :action=>"index", :controller=>"user"
      end
      @user.clear_password!
    end
  end

  def login
    @title = "Please login"
  	@videos = Video.order("created_at desc")
  	@user = User.new
    if request.get?
      @user = User.new( :rememberme=>cookies[:rememberme] || "0" )
    elsif request.post? and params[:user]
      @user = User.new(params[:user])
      user = User.find_by_email_and_password(@user.email, @user.password)
      if user
        user.login!(session)
        @user.remember? ? user.remember!(cookies) : user.forget!(cookies)
        @user.clear_password!
        redirect_to :action=>"index", :controller=>"user"
        return
      else
				@user.errors.add_to_base("You did not input your username") if @user.uname.length == 0
				@user.errors.add_to_base("You did not input your password") if @user.pword.length == 0
				@user.errors.add_to_base("Invalid username or password") if @user.uname.length > 0 or @user.pword.length > 0
        @user.clear_password!
      end
    end
  end

end
