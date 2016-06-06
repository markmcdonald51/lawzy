class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  MAX_SESSION_TIME = 30 * 60 # minutes x seconds
  #auto_session_timeout 30.minutes
  before_filter :session_expires, :check_user_data, :signed_in?

  #before_filter :set_paper_trail_whodunnit

  # for working from home dev
  #before_filter :current_user # :check_user_data

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  #ActiveScaffold.set_defaults do |config|
  #  config.security.default_permission = false
  #end


  #unless Rails.application.config.consider_all_requests_local
  #   rescue_from ActionController::RoutingError, with: -> { render_404  }
  #end

  #OmniAuth.config.on_failure = -> (env) do
  #  redirect_to auth_failure_url, :alert => exception.message
    #Rack::Response.new(['302 Moved'], 302, 'Location' => env['omniauth.origin'] || "/").finish
  #end


   private

     def session_expires
       if !session[:expire_at].nil? and session[:expire_at] < Time.now
         reset_session
         flash[:notice] = "Login sessions are limited to #{MAX_SESSION_TIME / 60} minutes. You have been logged out!"
       end
       session[:expire_at] = MAX_SESSION_TIME.seconds.from_now
       return true
     end

     # returns the signed in user
     def current_user
      #@current_user = User.find_by(uid: '200189162')  ##DEBUG work from home
      #@current_user = User.find_by(uid: '200051351')  ##DEBUG work as Andrew Sams
      
      @current_user = User.first
      #@current_user || User.find(session[:user_id]) if session[:user_id] rescue nil
     end

     # this method is called from non public controllers
     def signed_in?
         #redirect_to root_url if current_user.nil?
       redirect_to login_url if current_user.nil?
     end

     helper_method :current_user
     helper_method :signed_in?

     def set_locale
       I18n.locale = session[:locale] || I18n.default_locale
       session[:locale] = I18n.locale

       #Geocoder.search(IP_ADDRESS)
     end

     # amoniauth with twitter force this check to prevent user data nil
     def check_user_data
       if !current_user.nil?
         #redirect_to profile_path if current_user.email.nil? || current_user.first_name.nil? || current_user.last_name.nil?
       end
     end


     #def store_ip
     #  unless current_user
     #    session[:user_ip] ||= ip_address  = '67.170.151.145' #request.remote_ip
     #    session[:geo_location] ||= Geocoder.search(session[:user_ip])
     #  end
     #end

     helper_method  :check_user_data














end





