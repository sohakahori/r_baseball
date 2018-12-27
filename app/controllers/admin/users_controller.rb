class Admin::UsersController < Admin::ApplicationController
  def index
    @search_word = params[:search_word]
    if @search_word.present?
      @users = User.search_like_users(@search_word).page(params[:page]).per(30)
    else
      @users = User.all.page(params[:page]).per(30)
    end
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
