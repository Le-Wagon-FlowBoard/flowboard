class CreateProjectPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :project_permissions do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :access, null: false

      t.timestamps
    end
  end
end
