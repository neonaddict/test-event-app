class SessionsController < ApplicationController
  def new 
  end
  
  def create
    puts params.inspect
    user = AdminUser.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = 'Hello, admin!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Неправильный email/пароль'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
