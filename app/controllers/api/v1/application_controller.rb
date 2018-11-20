class Api::V1::ApplicationController < ActionController::Base
  include Api::ApiHelper
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  before_action :authenticate_user!
end
