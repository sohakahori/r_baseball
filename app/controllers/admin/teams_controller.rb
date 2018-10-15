class Admin::TeamsController < Admin::ApplicationController




  def index
    @teams = Team.all.order_league.page(params[:page]).per(6)
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
      flash.now['danger'] = '入力項目に不備があります。'
      render 'new'
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
