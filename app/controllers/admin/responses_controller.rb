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

  def destroy
    begin
      response = Response.find(params[:id])
      response.destroy
      flash[:success] = "コメントを削除しました"
      redirect_back(fallback_location: admin_board_responses_path(params[:board_id], page: params[:page])) and return
    rescue => e
      flash[:danger] = e.message
      redirect_back(fallback_location: admin_board_responses_path(params[:board_id], page: params[:page])) and return
    end
  end
end
