class Admin::PlayersController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  before_action :get_team, only: [:index, :new, :create]
  before_action :get_player, only: [:edit, :show, :update, :destroy]
  before_action :check_params_process, only: [:edit, :update, :destroy, :show]

  def index
    @players = @team.players.page(params[:page]).per(30)
  end

  def show
  end

  def new
    @player = @team.players.build
  end

  def create
    @player = @team.players.build(player_params)
    if @player.save
      flash[:success] = "選手の登録に成功しました。"
      redirect_back(fallback_location: admin_team_players_path(@player.team))
    else
      flash.now[:danger] = '入力項目に不備があります。'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @player.update player_params
      flash[:success] = '選手の変更に成功しました。'
      redirect_to edit_admin_team_player_path(@player.team, @player)
    else
      flash.now[:danger] = '入力項目に不備があります。'
      render 'edit'
    end
  end

  def destroy
    @player.destroy
    flash[:success] = '選手の削除に成功しました。'
    redirect_to admin_team_players_path(@player.team) and return
  end

  private
  def get_team
    @team = Team.find params[:team_id]
  end

  def get_player
    @player = Player.find params[:id]
  end

  def check_params_process
    unless params[:team_id].to_i == @player.team_id
      flash[:danger] = "パラメータが不正です。"
      redirect_to admin_team_players_path(@player.team) and return
    end
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
