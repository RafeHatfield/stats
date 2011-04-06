class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  around_filter :select_shard
    
  def domain_extension
    if request.domain
      request.domain.split('.').last.to_sym
    else
      :com
    end
  end

  def domain_extension?(lang)
    lang == domain_extension
  end
  helper_method :domain_extension?
  
  def set_locale
    extensions = {
      :com => :en,
      :de => :de
    }
    I18n.locale = extensions[domain_extension]    
  end
  
  def select_shard
    if SHARDING_ENABLED
      Octopus.using(domain_extension) { yield }
    else
      yield
    end
  end
  
protected
  
  def set_start_and_end_date
    if params[:start_date].present?
      @start_date = params[:start_date].to_date
      session[:start_date] = @start_date
    elsif session[:start_date].present?
      @start_date = session[:start_date]
    else
      @start_date = 7.days.ago.to_date
    end
    
    if params[:end_date].present?
      @end_date = params[:end_date].to_date
      session[:end_date] = @start_date
    elsif session[:end_date].present?
      @end_date = session[:end_date]
    else
      @end_date = Date.today
    end
  end
  
  
  # Ensure that the supplied id and key match our encoding.
  # Setup the @user object with authentication info.
  def get_user
    key = params[:key]
    writer_id = key.alphadecimal
    if !Writer.create(domain_extension).exists?(writer_id)
      render :file => "/public/404.html", :status => 404
      return false
    end
    @user = {:id => writer_id, :key => key}
  end
  
end
