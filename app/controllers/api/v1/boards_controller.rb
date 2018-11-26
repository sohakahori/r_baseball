class Api::V1::BoardsController < Api::V1::ApplicationController

  def index
    if params[:title].present?
      @boards = Board.search_title(params[:title]).page(params[:page]).per(30)
    else
      @boards = Board.all.page(params[:page]).per(30)
    end
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    @board = current_user.boards.build(bord_params)
    if @board.save
      render 'create', formats: 'json', handlers: 'jbuilder'
    else
      render 'error', formats: 'json', handlers: 'jbuilder'
    end
  end

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
