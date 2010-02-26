class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user, :iphone_section, :development_section

  filter_parameter_logging :password

  before_filter :require_user, :override_browser_type

  protected

  def iphone_section
    if iphone_request?
      yield
    elsif (RAILS_ENV == 'development') && session[:override_browser]
      yield if session[:override_browser] == :iphone 
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def development_section
    yield if RAILS_ENV == 'development'
  end
  
  private
  
  def override_browser_type
    if params[:browser]
      session[:override_browser] = params[:browser].to_sym
    end
  end

end
