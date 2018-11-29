class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all.page(params[:page]).per(30)
  end

  def destroy
    begin
      User.find(params[:id]).destroy
    rescue => e
      flash[:danger] = e.message
      redirect_back(fallback_location: admin_users_path) and return
    end
    flash[:success] = "ユーザーの削除に成功しました。"
    redirect_back(fallback_location: admin_users_path) and return
  end
end
