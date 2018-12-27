class Admin::AdminsController < Admin::ApplicationController
  require 'csv'
  before_action :set_admin, only:[:edit, :update, :destroy]

  def index
    respond_to do |format|
      @admins = Admin
      @search_word = params[:search_word]

      format.html do
        if @search_word.present?
          search_admins
        end
        @admins = @admins.updated_at_desc.id_desc.page(params[:page]).per(15)
      end
      format.csv do
        if @search_word.present?
          search_admins
        else
          @admins = @admins.all
        end
        products_csv
      end
    end
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

  def search_admins
    @admins = @admins.search_full_name(@search_word)
                  .or(@admins.search_email(@search_word))
  end

  def products_csv
    csv_date = CSV.generate do |csv|
      csv_column_names = ["ID", "full_name", "メールアドレス", "権限", "作成日時", "更新日時"]
      csv << csv_column_names
      @admins.each do |admin|
        csv_column_values = [
            admin.id,
            admin.full_name,
            admin.email,
            admin.role,
            admin.created_at.strftime('%Y年%m月%d日 %H:%M:%S'),
            admin.updated_at.strftime('%Y年%m月%d日 %H:%M:%S')
        ]
        csv << csv_column_values
      end
    end
    send_data(csv_date, filename: "admins.csv")
  end
end