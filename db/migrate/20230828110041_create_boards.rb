class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.text :description
      t.references :project, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
