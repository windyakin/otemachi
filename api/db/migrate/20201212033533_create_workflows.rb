class CreateWorkflows < ActiveRecord::Migration[6.0]
  def change
    create_table :workflows do |t|
      t.string :name, null: false, unique: true
      t.text :structure, null: false

      t.timestamps
    end
  end
end
