# == Schema Information
#
# Table name: step_transitions
#
#  id          :bigint           not null, primary key
#  to_state    :string(255)      not null
#  metadata    :text(65535)
#  sort_key    :integer          not null
#  step_id     :bigint           not null
#  most_recent :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_step_transitions_parent_most_recent  (step_id,most_recent) UNIQUE
#  index_step_transitions_parent_sort         (step_id,sort_key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (step_id => steps.id)
#
class StepTransition < ApplicationRecord
  include Statesman::Adapters::ActiveRecordTransition

  # If your transition table doesn't have the default `updated_at` timestamp column,
  # you'll need to configure the `updated_timestamp_column` option, setting it to
  # another column name (e.g. `:updated_on`) or `nil`.
  #
  # self.updated_timestamp_column = :updated_on
  # self.updated_timestamp_column = nil

  belongs_to :step, inverse_of: :transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = step.transitions.order(:sort_key).last
    return unless last_transition.present?
    last_transition.update_column(:most_recent, true)
  end
end
