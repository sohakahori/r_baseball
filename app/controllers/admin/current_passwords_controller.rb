class Admin::CurrentPasswordsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def new
    @admin = current_admin
  end

  def create
    @admin = current_admin
    if @admin.update_with_password admin_params
      flash[:success] = "パスワードの変更に成功しました。"
      sign_in(current_admin, bypass: true)
      redirect_to new_admin_current_password_path
    else
      flash.now[:danger] = '入力項目に不備があります。'
      render 'new'
    end
  end

  private
  def admin_params
    params.require(:admin).permit(
        :password,
        :password_confirmation,
        :current_password
    )
  end
end
