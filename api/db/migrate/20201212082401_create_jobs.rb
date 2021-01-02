class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.references :workflow, null: false
      t.bigint :job_number, null: false
      t.text :structure, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps

      t.index [:workflow_id, :job_number], unique: true
    end
  end
end
