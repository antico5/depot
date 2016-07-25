module CurrentUser
  def current_user
    @current_user_ ||= User.find session[:user_id] if session[:user_id]
  rescue ActiveRecord::RecordNotFound
  end

  def log_user_in user
    session[:user_id] = user.id
  end

  def log_user_out
    @current_user_ = nil
    session[:user_id] = nil
  end

  def CurrentUser.included(controller)
    controller.helper_method :current_user
  end
end
