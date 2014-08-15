module ApplicationHelper

  require 'string'
  require 'object'
	
	def gravatar_for(user, options={:size=>50})
		gravatar_image_tag(user.email.downcase, :alt=>user.name, :class=>'gravatar', :gravatar=>options)
	end
	
  def protect
    unless logged_in?
      flash[:notice] = "Please log in first."
      redirect_to :action=>"login", :controller=>"site"
      return false
    end
  end
  
  # Return a link for use in site navigation.
  def nav_link(text, controller, action="index")
    link_to_unless_current text, :id => nil, :action => action, :controller => controller
  end
  
  # Return true if some user is logged in, false otherwise.
  def logged_in?
    not session[:user_id].nil?
  end
  
  def text_field_for(form, field, size=HTML_TEXT_FIELD_SIZE, maxlength=DB_STRING_MAX_LENGTH)
    label = content_tag("label", "#{field.humanize}:", :for => field)
    form_field = form.text_field field, :size => size, :maxlength => maxlength
    content_tag("div", "#{label} #{form_field}", :class => "form_row")
  end
  
  # Return true if results should be paginated.
  def paginated?
    @pages and @pages.length > 1
  end

# from sample app
	def logo
		link_to(image_tag("logo.png", :alt=>"Sample app", :class=>"round"), root_path)
	end
	
	def signed_in?
		!current_user.nil?
	end
	
  def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		self.current_user = user
	end
	
	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end
	
	def deny_access
		store_location
		redirect_to signin_path, :notice=>'Please sign in to access the page'
	end
	
	def authenticate
		deny_access unless signed_in?
	end

	def redirect_to_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= user_from_remember_token
	end
	
	def current_user?(user)
		user == current_user
	end
	
	def wrap(content)
		raw(content.split.map{|s| wrap_long_string(s)}.join(' '))
	end
	
	private
	
	def user_from_remember_token
		User.authenticate_with_salt(*remember_token)
	end
	
	def remember_token
		cookies.signed[:remember_token] || [nil, nil]
	end
	
	def store_location
		session[:return_to] = request.fullpath
	end
	
	def clear_return_to
		session[:return_to] = nil
	end
	
	def wrap_long_string(text, maxwidth = 30)
		zero_width_space = "&#8203;"
		regex = /.{1,#{max_width}}/
		(text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
	end
# from sample app up to here

end


