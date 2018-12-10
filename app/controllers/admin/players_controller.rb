class Admin::PlayersController < Admin::ApplicationController
  require 'csv'

  before_action :get_team, only: [:index, :new, :create, :import_csv]
  before_action :get_player, only: [:edit, :show, :update, :destroy]
  before_action :check_params_process, only: [:edit, :update, :destroy, :show]

  def index
    @search_word = params[:search_word]
    @players = @team.players

    if @search_word.present?
      @players = @players.search_name(@search_word).or(@players.search_no(@search_word))
    end

    respond_to do |format|
      format.html do
        @players = @players.page(params[:page]).per(30)
      end
      format.csv do
        products_csv
      end
    end
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

  def import_csv
    if params[:players_csv].blank?
      flash[:danger] = 'CSVファイルを選択してください。'
      redirect_back(fallback_location: new_admin_team_player_path(@team)) and return
    else
      begin
        import_count = Player.import_player params[:players_csv]
      rescue => e
        flash[:danger] = "入力形式が不正です。 #{e.message}"
        redirect_back(fallback_location: new_admin_team_player_path(@team)) and return
      end
      flash[:success] = "#{import_count}の選手を登録しました。"
      redirect_back(fallback_location: new_admin_team_player_path(@team)) and return
    end
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
        :detail,
        :image,
        :remove_image
    )
  end

  def products_csv
    csv_date = CSV.generate do |csv|
      csv_column_names = ["ID", "球団", "背番号","名前", "守備位置", "生年月日", "身長", "体重", "投	", "打", "作成日時", "更新日時"]
      csv << csv_column_names
      @players.each do |player|
        csv_column_values = [
            player.id,
            player.team.name,
            player.no,
            player.name,
            player.position_i18n,
            player.birthday,
            player.height,
            player.weight,
            player.throw_i18n,
            player.hit_i18n,
            player.created_at.strftime('%Y年%m月%d日 %H:%M:%S'),
            player.updated_at.strftime('%Y年%m月%d日 %H:%M:%S')
        ]
        csv << csv_column_values
      end
    end
    send_data(csv_date,filename: "player.csv")
  end

end
