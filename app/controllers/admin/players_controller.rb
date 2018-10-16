class Admin::PlayersController < Admin::ApplicationController
  def index
    @players = Player.search_team(params[:team_id]).page(params[:page])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
