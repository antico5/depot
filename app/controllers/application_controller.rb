class ApplicationController < ActionController::Base
  include CurrentUser

  protect_from_forgery with: :exception

  before_action :authorize!
  before_action :set_i18n_locale_from_params

  protected

    def authorize!
      current_user || redirect_to(login_url, notice: 'Please log in')
    end

    def set_i18n_locale_from_params
      return unless params[:locale]

      if I18n.available_locales.map(&:to_s).include? params[:locale]
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "There is no translation associated for #{ params[:locale] }."
        logger.error flash.now[:notice]
      end
    end
end
