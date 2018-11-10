class Admin::AdminsController < ApplicationController
  layout 'admin'

  def index
    @admins = Admin.updated_at_desc.page(params[:page]).per(15)
  end
end
