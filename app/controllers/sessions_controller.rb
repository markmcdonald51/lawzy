class SessionsController < ApplicationController

  skip_before_filter :check_user_data, only: [:destroy, :active, :timeout]
  skip_before_filter :signed_in?, only: [:create, :failure, :active, :timeout]
  skip_before_filter :verify_authenticity_token

  #auto_session_timeout_actions


=begin
  def active
   render_session_status
  end

  def timeout
    render_session_timeout
  end
=end
  def create
    # TODO: need a way around this for user.is_application_administrator
    user = User.from_omniauth(request.env["omniauth.auth"])
    if (user.try(:is_application_administrator) or WhiteList.find_by(uid: request.env["omniauth.auth"]['extra']['raw_info'][:uidnumber].first))
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      user.login_count += 1
      if user.login_count == 1
        puts "User login count = 1!"
        # TODO: Fix
        #system_contact_user = org.contact.email
        # SystemNotification.new_user_system_login_email(system_contact_user, user)
      end
      user.save
      #flash[:notice] = "Welcome #{user.first_name} #{user.last_name}!" # t('welcome')
    else
      flash[:notice] = 'Please contact some *ADMIN_EMAIL* for white listing to this program.'
    end
    redirect_to root_url #, notice: notice
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You are now signed out!'
    redirect_to root_url
  end

  def failure
    flash[:notice] = 'Incorrect Login Credentials. Please try again!'
    redirect_to root_url
  end

end
