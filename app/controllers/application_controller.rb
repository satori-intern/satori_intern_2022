class ApplicationController < ActionController::Base
  # before_action :authenticate_user!

  # ログイン後のリダイレクト先の指定
  def after_sign_in_path_for(resource)
    static_pages_home_path
  end

  # ログアウト後のリダイレクト先の指定
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
