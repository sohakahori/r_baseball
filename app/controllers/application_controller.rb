class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session


  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      root_path
    elsif resource.is_a?(Admin)
      admin_teams_path
    else
      root_path
    end
  end


  def after_sign_out_path_for(resource)
    if resource == :user
      new_user_session_path
    elsif resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end
end
