class CreateStepTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :step_transitions do |t|
      t.string :to_state, null: false
      t.text :metadata
      t.integer :sort_key, null: false
      t.bigint :step_id, null: false
      t.boolean :most_recent

      # If you decide not to include an updated timestamp column in your transition
      # table, you'll need to configure the `updated_timestamp_column` setting in your
      # migration class.
      t.timestamps null: false
    end

    # Foreign keys are optional, but highly recommended
    add_foreign_key :step_transitions, :steps

    add_index(:step_transitions,
              %i(step_id sort_key),
              unique: true,
              name: "index_step_transitions_parent_sort")
    add_index(:step_transitions,
              %i(step_id most_recent),
              unique: true,

              name: "index_step_transitions_parent_most_recent")
  end
end
