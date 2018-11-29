class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all.page(params[:page]).per(30)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "ユーザーの削除に成功しました。"
    redirect_back(fallback_location: admin_users_path)
  end
end
