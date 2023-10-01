class SessionsController < ApplicationController
  # destroyアクションに対してはCSRFトークンの検証をスキップする
  protect_from_forgery except: :destroy

  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      # セッション固定攻撃から保護する
      reset_session
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in(@user)
      redirect_to forwarding_url || @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
