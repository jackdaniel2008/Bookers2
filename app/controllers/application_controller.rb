class ApplicationController < ActionController::Base
  # ログインしていない場合、トップ画面とアバウト画面以外の表示を制限
  before_action :authenticate_user!, except: [:top, :about]
  # ユーザー登録時と編集時にそれぞれ必要な項目の指定
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログインしていない場合は投稿内容やユーザー情報の編集ができない
  before_action :is_matching_login_user, only: [:edit, :update]

  def after_sign_in_path_for(resource)
    user_path(resource)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction])
  end
end