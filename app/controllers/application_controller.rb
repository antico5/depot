class ApplicationController < ActionController::Base
  include CurrentUser

  protect_from_forgery with: :exception

  before_action :authorize!
  before_action :set_i18n_locale

  protected

    def authorize!
      current_user || redirect_to(login_url, notice: 'Please log in')
    end

    def set_i18n_locale
      locale = params[:locale]
      session[:locale] = locale if locale

      if session[:locale]
        if I18n.available_locales.map(&:to_s).include? session[:locale]
          I18n.locale = session[:locale]
        else
          flash.now[:notice] = "There is no translation associated for #{ session[:locale] }."
          logger.error flash.now[:notice]
        end
      end
    end
end
