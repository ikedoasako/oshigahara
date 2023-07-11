# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
   before_action :configure_sign_in_params, only: [:create]
   before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  
  #ゲストログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
  #退会しているかを判断するメソッド
  def user_state
    #ログイン画面から送られたemailを確認、Userモデルに同じemailのアカウントが登録されているか探す
    #入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    #アカウントを取得できなかった場合、このメソッドを終了
    return if !@user
    #アカウントが存在している場合、登録済パスワードとログイン画面で入力されたパスワードが一致しているか確認する
    if @user.is_deleted?
    #処理が真(true)だった場合、そのアカウントのis_deletedカラムに格納されている値を確認する
    #trueだった場合、退会しているのでサインアップ画面に戻す
    redirect_to new_user_registration_path
    end
    #falseだった場合、退会していないのでそのままログイン処理を実行
    unless @user.valid_password?(params[:user][:password])
     redirect_to new_user_session_path
    end
  end
  

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
