class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  # ログイン後のリダイレクト先の指定
  def after_sign_in_path_for(resource)
    boards_index_path
  end

  # ログアウト後のリダイレクト先の指定
  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
