class Admin::ResponsesController < Admin::ApplicationController
  def index
    @user_search_word = params[:user_search_word]
    @comment_search_word = params[:comment_search_word]
    @board = Board.find(params[:board_id])

    @responses = @board.responses.includes(:user)
    if @user_search_word.present?
      @responses = @responses.merge(User.search_like_users(@user_search_word)).references(:user)
    end

    if @comment_search_word.present?
      @responses = @responses.search_like_body(@comment_search_word)
    end

    @responses = @responses.page(params[:page]).per(30)
  end
end
