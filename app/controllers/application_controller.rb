class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
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
end
