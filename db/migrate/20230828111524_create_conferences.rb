class CreateConferences < ActiveRecord::Migration[7.0]
  def change
    create_table :conferences do |t|
      t.string :name, null: false
      t.datetime :date, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
