class AddRoleToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :role, :string
  end
end
