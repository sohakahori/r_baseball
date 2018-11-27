class Api::V1::ResponsesController < Api::V1::ApplicationController
  def index
    @responses = Board.find(params[:board_id]).responses.page(params[:page]).per(30)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
