class Admin::BoardsController < Admin::ApplicationController

  def index
    @title_search   = params[:title_search]
    @comment_search = params[:comment_search]
    @user_search    = params[:user_search]

    @boards = Board.includes(:responses).includes(:user)

    if @title_search.present?
      @boards = @boards.search_title(@title_search)
    end

    if @comment_search.present?
      @boards = @boards.merge(Response.search_like_body(@comment_search)).references(:responses)
    end

    if @user_search.present?
      @boards = @boards.merge(User.search_like_users(@user_search)).references(:user)
    end

    if @title_search.blank? && @comment_search.blank? && @user_search.blank?
      @boards = @boards.all
    end

    @boards = @boards.page(params[:page]).per(30)
  end
end
