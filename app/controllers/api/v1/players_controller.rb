class Api::V1::PlayersController < Api::V1::ApplicationController
  before_action :get_team, only: [:index]
  before_action :get_player, only: [:show]

  api :GET, '/api/v1/teams/:team_id/players', '選手一覧を返します'
  # エラーの指定はこのような形で
  error code: 401, desc: 'Unauthorized'
  error code: 404, desc: 'Not Found'

  # 利用例は example に記載
  example <<-EDOC
  ## Request
    ### Header 
    {
      Content-Type:application/json,
      access-token:jnvx5l-6EamupzK2BO7Jlg,
      client:27g9tBTLDVKEhmT5etvDdw,
      uid:test@test.com
    }
    ### Body 
    {}
  ## Response
  ### 正常系
  {
    "players": [
        {
            "id": 7,
            "team_id": 1,
            "no": "5",
            "name": "青木 美月",
            "image": null,
            "position": "right_fielder",
            "birthday": "1988.02.08",
            "height": "178",
            "weight": "100",
            "throw": "left_throw",
            "hit": "left_hit",
            "detail": null,
            "created_at": "2018-11-25T22:59:04.000+09:00",
            "updated_at": "2018-11-25T22:59:04.000+09:00"
        },
        {
            "id": 9,
            "team_id": 1,
            "no": "78",
            "name": "和田 陸",
            "image": null,
            "position": "first_baseman",
            "birthday": "1988.02.08",
            "height": "175",
            "weight": "96",
            "throw": "left_throw",
            "hit": "right_hit",
            "detail": null,
            "created_at": "2018-11-25T22:59:04.000+09:00",
            "updated_at": "2018-11-25T22:59:04.000+09:00"
        },
        {
            "id": 14,
            "team_id": 1,
            "no": "98",
            "name": "新井 颯太",
            "image": null,
            "position": "third_baseman",
            "birthday": "1988.02.08",
            "height": "171",
            "weight": "103",
            "throw": "left_throw",
            "hit": "right_hit",
            "detail": null,
            "created_at": "2018-11-25T22:59:04.000+09:00",
            "updated_at": "2018-11-25T22:59:04.000+09:00"
        }
    ],
    "meta": {
        "page": 1,
        "per_page": 8,
        "page_count": 8,
        "total_count": 24,
        "link": {
            "self": "http://localhost:3000/api/v1/teams/1/players?page=1",
            "first": "http://localhost:3000/api/v1/teams/1/players?page=1",
            "previous": null,
            "next": "http://localhost:3000/api/v1/teams/1/players?page=2",
            "last": "http://localhost:3000/api/v1/teams/1/players?page=8"
        }
    }
  }
  ### Error
    {
      "errors": [
        "ログインまたは登録が必要です。"
      ]
    }
  EDOC
  def index
    @players = @team.players.page(params[:page]).per(3)
  end

  api :GET, '/api/v1/teams/:team_id/players/:id', '選手詳細を返します'
  # エラーの指定はこのような形で
  error code: 401, desc: 'Unauthorized'
  error code: 404, desc: 'Not Found'

  # 利用例は example に記載
  example <<-EDOC
  ## Request
    ### Header 
    {
      Content-Type:application/json,
      access-token:jnvx5l-6EamupzK2BO7Jlg,
      client:27g9tBTLDVKEhmT5etvDdw,
      uid:test@test.com
    }
    ### Body 
    {}
  ## Response
  ### 正常系
  {
    "id": 7,
    "team_id": 1,
    "no": "5",
    "name": "青木 美月",
    "image": null,
    "position": "right_fielder",
    "birthday": "1988.02.08",
    "height": "178",
    "weight": "100",
    "throw": "left_throw",
    "hit": "left_hit",
    "detail": null,
    "created_at": "2018-11-25T22:59:04.000+09:00",
    "updated_at": "2018-11-25T22:59:04.000+09:00"
  }
  ### Error
    {
      "errors": [
        "ログインまたは登録が必要です。"
      ]
    }
  EDOC
  def show
  end

  def get_team
    @team = Team.find params[:team_id]
  end

  def get_player
    @player = Player.find params[:id]
  end

end
