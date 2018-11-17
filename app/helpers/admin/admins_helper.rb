module Admin::AdminsHelper
  def is_new_request?
    request.path_info == new_admin_admin_path
  end
end
