class Api::V1::ResponsesController < Api::V1::ApplicationController

  before_action :get_board, only: [:index, :create, :destroy]

  api :GET, '/v1/boards/:board_id/responses', 'コメント一覧を返します'
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
    "responses": [
      {
        "id": 1,
        "body": "Iceland",
        "created_at": "2018-11-28T00:35:46.000+09:00",
        "updated_at": "2018-11-28T00:35:46.000+09:00",
        "board_id": 1,
        "board_title": "タイトル1",
        "user": {
          "id": 6,
          "first_name": "太一",
          "last_name": "後藤",
          "nickname": "佐藤 遼"
        }
      },
      {
        "id": 2,
        "body": "Sweden",
        "created_at": "2018-11-28T00:35:46.000+09:00",
        "updated_at": "2018-11-28T00:35:46.000+09:00",
        "board_id": 1,
        "board_title": "タイトル1",
        "user": {
          "id": 6,
          "first_name": "太一",
          "last_name": "後藤",
          "nickname": "佐藤 遼"
        }
      }
    ],
    "meta": {
      "page": 1,
      "per_page": 25,
      "page_count": 25,
      "total_count": 50,
      "link": {
        "self": "http://localhost:3000/api/v1/boards/1/responses?page=1",
        "first": "http://localhost:3000/api/v1/boards/1/responses?page=1",
        "previous": null,
        "next": "http://localhost:3000/api/v1/boards/1/responses?page=2",
        "last": "http://localhost:3000/api/v1/boards/1/responses?page=25"
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
    @responses = @board.responses.page(params[:page]).per(30)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  api :POST, '/v1/boards/:boards_id/responses', 'コメントを登録します'
  # エラーの指定はこのような形で
  error code: 400, desc: 'body必須'
  error code: 401, desc: 'Unauthorized'
  error code: 404, desc: 'Not Found'
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
  {
    "response": {
      "body": "コメント"
    }
  }
  ## Response
  ### 正常系
  {
    "status": "success",
    "response": {
      "id": 2002,
      "body": "コメント",
      "created_at": "2018-11-28T00:55:49.000+09:00",
      "updated_at": "2018-11-28T00:55:49.000+09:00",
      "board_id": 1,
      "board_title": "タイトル1",
      "user": {
        "id": 7,
        "first_name": "名前",
        "last_name": "苗字",
        "nickname": "ニックネーム"
      }
    }
  }
  ### Error(未ログイン)
    {
      "errors": [
        "ログインまたは登録が必要です。"
      ]
    }

  ### Error(パラメータ)
  {
    "code": "400",
    "status": "error",
    "data": {
      "response": {
        "body": null
      }
    },
    "errors": {
      "body": [
        "を入力してください"
      ],
      "full_messages": [
        "Bodyを入力してください"
      ]
    }
  }
  EDOC
  def create
    @response = @board.responses.build(response_params)
    @response.user = current_user
    if @response.save
      render 'create', formats: 'json', handlers: 'jbuilder' and return
    else
      @params = params
      render 'error', formats: 'json', handlers: 'jbuilder' and return
    end
  end

  api :DELETE, '/v1/boards/:board_id/responses/:id', 'コメントを削除します。'
  error code: 400, desc: '自作コメントのみ削除可能'
  error code: 401, desc: 'Unauthorized'
  error code: 404, desc: 'Not Found'
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
    "status": "success"
  }
  ### Error(未ログイン)
  {
    "errors": [
      "ログインまたは登録が必要です。"
    ]
  }

  ### Error(パラメータ)
  {
    "code": "400",
    "status": "error",
    "errors": [
      "コメントは作成者しか削除することはできません。"
    ]
  }
  EDOC
  def destroy
    response = Response.find(params[:id])
    if response.user != current_user
      render :json => {"code" => "400","status" => "error", "errors" => ["コメントは作成者しか削除することはできません。"]} and return
    end
    response.destroy
    render :json => {"status" => "success"} and return
  end

  private
  def response_params
    params.require(:response).permit(:body)
  end

  def get_board
    @board = Board.find(params[:board_id])
  end
end
