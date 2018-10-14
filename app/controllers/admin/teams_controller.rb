class Admin::TeamsController < Admin::ApplicationController




  def index
    @teams = Team.all.order_league.page(params[:page]).per(6)
  end

  def new
    @teams = Team.new
  end

  def create
    if Team.create team_params
      flash[:success] = '球団の登録に成功しました。'
      redirect_to admin_teams_path
    else
    end
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
end
