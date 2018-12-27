class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private
  def sign_up_params
    params.permit(:first_name, :last_name, :email, :nickname, :password, :password_confirmation)
  end

  def account_update_params
    params.permit(:first_name, :last_name, :email, :nickname)
  end

end
