class Admin::TeamsController < Admin::ApplicationController

  def index
    @tems = Team.all
  end

  def new
  end
end
