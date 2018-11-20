class Public::ApplicationController < ApplicationController
  layout 'public'
  before_action :authenticate_user!

end