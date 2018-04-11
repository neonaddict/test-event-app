class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :admin_is_logged_in, only: [:new, :edit, :update, :destroy]
  include EventsHelper
  include SessionsHelper

  private
  
  # Confirms that admin is logged in.
  def admin_is_logged_in
    unless logged_in?
      flash[:danger] = 'Доступ закрыт'
      redirect_to root_url
    end
  end

end
