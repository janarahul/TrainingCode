# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	before_filter :require_login

	around_filter :catch_exceptions

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  private 

  def require_login
  	unless logged_in?
  		flash[:error] = "You must be loged in"
  		redirect_to new_login_url
  end

  def logged_in?
    !!current_user
  end

  def catch_exceptions
  	yield
  rescue => exception
  	logger.debug "Caught exception #{exception}"
  	raise
  end

  #other ways to use filters
  #block
  before_filter do |controller|
  	redirect_to new_login_url unless controller.send(:logged_in?)
  end

  #using class
  before_filter Loginfilter
end

class Loginfilter
	def self.filter(controller)
		unless controller.send(:logged_in?) 
			controller.flash[:error] = "Not logged_in"
			controller.redirect_to controller.new_login_url
		end
	end
end