class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # def after_sign_in_path_for(resource)
  #   admin_teams_path
  # end
  #
  # def after_sign_out_path_for(resource)
  #   new_admin_session_path
  # end

  # def after_sign_in_path_for(resource)
  #   admin_teams_path
  # end
  #
  # def after_sign_out_path_for(resource)
  #   new_admin_session
  # end

  # def after_sign_out_path_for(resource)
  #   resource = resource.to_s
  #   if resource == ("admin_user")
  #     root_path
  #   elsif resource == ("agency")
  #     new_agency_session_path
  #   elsif resource == ("owner")
  #     new_owner_session_path
  #   else
  #     root_path
  #   end
  # end
  #
  # def after_sign_in_path_for(resource)
  #   if resource.is_a?(AdminUser)
  #     admin_users_dashboards_path
  #   elsif resource.is_a?(Agency)
  #     agencies_dashboards_path
  #   elsif resource.is_a?(Owner)
  #     owners_dashboards_path
  #   else
  #   end
  # end
end
