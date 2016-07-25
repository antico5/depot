class SessionsController < ApplicationController
  include CurrentUser

  def new
  end

  def create
    user = User.find_by_name params[:name]
    if user.try(:authenticate, params[:password])
      log_user_in user
      redirect_to admin_index_url
    else
      redirect_to login_url, notice: 'Invalid username or password.'
    end
  end

  def destroy
    log_user_out
    redirect_to store_index_url, notice: 'Logged out.'
  end
end
