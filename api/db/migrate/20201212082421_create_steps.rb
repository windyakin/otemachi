class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.references :job, null: false
      t.string :name, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
