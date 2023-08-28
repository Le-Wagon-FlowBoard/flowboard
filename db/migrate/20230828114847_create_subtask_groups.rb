class CreateSubtaskGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :subtask_groups do |t|
      t.string :name, null: false
      t.references :task, null: false, foreign_key: true
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
