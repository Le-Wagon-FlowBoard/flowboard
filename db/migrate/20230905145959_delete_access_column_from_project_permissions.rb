class DeleteAccessColumnFromProjectPermissions < ActiveRecord::Migration[7.0]
  def change
    remove_column :project_permissions, :access
  end
end
