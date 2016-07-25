class ApplicationController < ActionController::Base
  include CurrentUser

  protect_from_forgery with: :exception

  before_action :authorize!

  protected

    def authorize!
      current_user || redirect_to(login_url, notice: 'Please log in')
    end
end
