class Admin::TeamsController < Admin::ApplicationController

  before_action :get_team, only: [:edit, :update, :destroy]


  def index
    @teams = Team.all.order_league.page(params[:page]).per(12)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new team_params
    if @team.save
      flash[:success] = '球団の登録に成功しました。'
      redirect_to admin_teams_path
    else
      flash.now[:danger] = '入力項目に不備があります。'
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @team.update team_params
      flash[:success] = '球団の変更に成功しました。'
      redirect_to admin_teams_path
    else
      flash.now[:danger] = '入力項目に不備があります。'
      render 'edit'
    end
  end

  def destroy
    @team.destroy
    flash[:success] = '球団の削除に成功しました。'
    redirect_to admin_teams_path
  end

  private
  def team_params
    params.require(:team).permit(
        :name,
        :stadium,
        :address,
        :league
    )
  end

  def get_team
    @team = Team.find(params[:id])
  end
end
