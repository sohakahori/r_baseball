class Api::V1::ResponsesController < Api::V1::ApplicationController

  before_action :get_board, only: [:index, :create, :destroy]

  def index
    @responses = @board.responses.page(params[:page]).per(30)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

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

  private
  def response_params
    params.require(:response).permit(:body)
  end

  def get_board
    @board = Board.find(params[:board_id])
  end
end
