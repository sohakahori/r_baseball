class Api::V1::TeamsController < Api::V1::ApplicationController

  api :GET, '/api/v1/teams', '球団一覧を返します'
  # エラーの指定はこのような形で
  # error code: 401, desc: 'Unauthorized'
  error code: 404, desc: 'Not Found'

  # 利用例は example に記載
  example <<-EDOC
  ## Request
    ### Header 
    {
      Content-Type:application/json,
      access-token:jnvx5l-6EamupzK2BO7Jlg,
      client:27g9tBTLDVKEhmT5etvDdw,
      uid:sohakahori@gmail.com
    }
    ### Body 
    {}
  ## Response
  ### 正常系
    {
      "teams": [
          {
              "id": 1,
              "name": "読売ジャイアンツ",
              "main_image": null,
              "stadium": "Zana Burgs",
              "address": "Apt. 121 6183 Leffler Trace, West Aurore, AL 77807-0884",
              "league": "1",
              "created_at": "2018-10-17T03:50:29.000+09:00",
              "updated_at": "2018-10-17T03:50:29.000+09:00"
          },
          {
              "id": 2,
              "name": "広島東洋カープ",
              "main_image": null,
              "stadium": "Miller Turnpike",
              "address": "80264 Treutel Glen, Heaneyport, PA 84539-3583",
              "league": "1",
              "created_at": "2018-10-17T03:50:29.000+09:00",
              "updated_at": "2018-10-17T03:50:29.000+09:00"
          },
          {
              "id": 3,
              "name": "阪神タイガース",
              "main_image": null,
              "stadium": "Sherlene Street",
              "address": "6326 Vernon Inlet, Wymantown, CA 18331-4227",
              "league": "1",
              "created_at": "2018-10-17T03:50:29.000+09:00",
              "updated_at": "2018-10-17T03:50:29.000+09:00"
          }
      ],
      "meta": {
          "page": 1,
          "per_page": 12,
          "page_count": 12,
          "total_count": 36,
          "link": {
              "self": "http://localhost:3000/api/v1/teams?page=1",
              "first": "http://localhost:3000/api/v1/teams?page=1",
              "previous": null,
              "next": "http://localhost:3000/api/v1/teams?page=2",
              "last": "http://localhost:3000/api/v1/teams?page=12"
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
    @teams = Team.all.order_league.page(params[:page]).per(12)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end



  api :GET, '/api/v1/teams/:id', '球団一覧を返します'
  # エラーの指定はこのような形で
  # error code: 401, desc: 'Unauthorized'
  error code: 404, desc: 'Not Found'

  # 利用例は example に記載
  example <<-EDOC
  $ curl http://localhost:3000/api/v1/teams/1
  ## Request
    ### Header 
    {
      Content-Type:application/json,
      access-token:jnvx5l-6EamupzK2BO7Jlg,
      client:27g9tBTLDVKEhmT5etvDdw,
      uid:sohakahori@gmail.com
    }
    ### Body 
    {}
  ## response
  ### 正常系
    {
      "id": 1,
      "name": "読売ジャイアンツ",
      "main_image": null,
      "stadium": "Zana Burgs",
      "address": "Apt. 121 6183 Leffler Trace, West Aurore, AL 77807-0884",
      "league": "1",
      "created_at": "2018-10-17T03:50:29.000+09:00",
      "updated_at": "2018-10-17T03:50:29.000+09:00"
    }
  ### Error
    {
      "errors": [
        "ログインまたは登録が必要です。"
      ]
    }
  EDOC
  def show
    @team = Team.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end
