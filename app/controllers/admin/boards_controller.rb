class Admin::BoardsController < Admin::ApplicationController

  def index
    @boards = Board.all.page(params[:page]).per(30)
  end
end
