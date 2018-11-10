class Admin::AdminsController < ApplicationController
  layout 'admin'

  def index
    @admins = Admin.updated_at_desc.page(params[:page]).per(15)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success] = "管理者の登録に成功しました。"
      redirect_to admin_admins_path
    else
      flash.now[:danger] = "入力項目に不備があります。"
      render :new
    end
  end

  private
  def admin_params
    params.require(:admin).permit(
        :first_name,
        :last_name,
        :email,
        :role,
        :password,
        :password_confirmation
    )
  end
end
