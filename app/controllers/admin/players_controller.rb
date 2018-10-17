class Admin::PlayersController < Admin::ApplicationController
  before_action :get_team, only: [:index, :new, :create]

  def index
    @players = @team.players.page(params[:page]).per(30)
  end

  def new
    @player = @team.players.build
  end

  def create
    @player = @team.players.build(player_params)
    if @player.save
      flash[:success] = "選手の登録に成功しました。"
      redirect_back(fallback_location: admin_team_players_path)
    else

    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def get_team
    @team = Team.find params[:team_id]
  end

  def player_params
    params.require(:player).permit(
        :no,
        :name,
        :birthday,
        :position,
        :height,
        :weight,
        :throw,
        :hit,
        :detail
    )
  end

end
