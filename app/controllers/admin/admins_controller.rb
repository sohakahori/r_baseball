class Admin::AdminsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_admin, only:[:edit, :update, :destroy]

  def index
    @admins = Admin.updated_at_desc.id_desc.page(params[:page]).per(15)
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

  def edit
  end

  def update
    if @admin.update(admin_params)
      flash[:success] = "管理者の変更に成功しました。"
      redirect_to admin_admins_path
    else
      flash.now[:danger] = "入力項目に不備があります。"
      render :edit
    end
  end

  def destroy
    @admin.destroy
    flash[:success] = "管理者の削除に成功しました。"
    redirect_to admin_admins_path
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

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
