class Api::V1::BoardsController < Api::V1::ApplicationController

  api :GET, '/api/v1/boards?title=title_name', 'スレッド一覧を返します'
  # エラーの指定はこのような形で
  error code: 400
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
    "bords": [
      {
        "id": 1,
        "title": "Nectar in a Sieve",
        "user_id": 5,
        "created_at": "2018-11-27T00:19:26.000+09:00",
        "updated_at": "2018-11-27T00:19:26.000+09:00",
        "user": {
            "id": 5,
            "first_name": "颯",
            "last_name": "田村"
        }
      },
      {
        "id": 2,
        "title": "Jesting Pilate",
        "user_id": 5,
        "created_at": "2018-11-27T00:19:26.000+09:00",
        "updated_at": "2018-11-27T00:19:26.000+09:00",
        "user": {
            "id": 5,
            "first_name": "颯",
            "last_name": "田村"
        }
      },
      {
        "id": 3,
        "title": "The Way Through the Woods",
        "user_id": 5,
        "created_at": "2018-11-27T00:19:26.000+09:00",
        "updated_at": "2018-11-27T00:19:26.000+09:00",
        "user": {
            "id": 5,
            "first_name": "颯",
            "last_name": "田村"
        }
      }
    ],
    "meta": {
      "page": 1,
      "per_page": 32,
      "page_count": 32,
      "total_count": 95,
      "link": {
        "self": "http://localhost:3000/api/v1/boards?page=1",
        "first": "http://localhost:3000/api/v1/boards?page=1",
        "previous": null,
        "next": "http://localhost:3000/api/v1/boards?page=2",
        "last": "http://localhost:3000/api/v1/boards?page=32"
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
    if params[:title].present?
      @boards = Board.search_title(params[:title]).page(params[:page]).per(30)
    else
      @boards = Board.all.page(params[:page]).per(3)
    end
    render 'index', formats: 'json', handlers: 'jbuilder'
  end


  api :POST, '/api/v1/boards', 'スレッドを登録します'
  # エラーの指定はこのような形で
  error code: 400, desc: 'title必須'
  error code: 400, desc: 'titleは30字以内'
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
    "board": {
      "title": "テスト"
    }
  }
  ## Response
  ### 正常系
  {
    "status": "success",
    "board": {
      "id": 96,
      "title": "テスト",
      "user_id": 6,
      "created_at": "2018-11-27T00:49:04.000+09:00",
      "updated_at": "2018-11-27T00:49:04.000+09:00",
      "user": {
        "id": 6,
        "first_name": "",
        "last_name": ""
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
      "board": {
        "title": null
      }
    },
    "errors": {
      "title": [
        "を入力してください"
      ],
      "full_messages": [
        "タイトルを入力してください"
      ]
    }
  }
  EDOC
  def create
    @board = current_user.boards.build(bord_params)
    @params = params
    if @board.save
      render 'create', formats: 'json', handlers: 'jbuilder'
    else
      render 'error', formats: 'json', handlers: 'jbuilder'
    end
  end

  api :DELETE, '/api/v1/boards/:id', 'スレッドを削除します。'
  error code: 400, desc: ':idは存在する'
  error code: 400, desc: '自作のスレッドのみ削除可能'
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

  ### Error(パラメータ1)
  {
    "code": "400",
    "errors": [
        "Couldn't find Board with 'id'=9911111"
    ]
  }
  ### Error(パラメータ2)
  {
    "code": "400",
    "errors": [
        "スレッドは作成者しか削除することはできません。"
    ]
  }
  EDOC
  def destroy
    begin
      @board = Board.find(params[:id])
      if current_user.id != @board.user.id
        render :json => {'code' => '400', 'errors' => ["スレッドは作成者しか削除することはできません。"]} and return
      end
      @board.destroy!
    rescue => e
      render :json => {'code' => '400', 'errors' => [e.message]} and return
    end

    render :json => {'status' => 'success'} and return
  end

  private
  def bord_params
    params.require(:board).permit(:title)
  end
end
