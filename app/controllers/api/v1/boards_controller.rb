class Api::V1::BoardsController < Api::V1::ApplicationController

  def index
    @boards = Board.all.page(params[:page]).per(30)
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
    @board = Board.find(params[:id])
    @board.destroy
    render :json => {'status' => 'success'}
  end

  private
  def bord_params
    params.require(:board).permit(:title)
  end
end
