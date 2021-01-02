# == Schema Information
#
# Table name: steps
#
#  id         :bigint           not null, primary key
#  job_id     :bigint           not null
#  name       :string(255)      not null
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_steps_on_job_id  (job_id)
#
class Step < ApplicationRecord
  belongs_to :job
  has_many :transitions, class_name: "StepTransition", autosave: false

  validates_presence_of :name
  validates_presence_of :start_at, if: Proc.new { |step| step.end_at.present? }

  delegate :can_transition_to?, :current_state, :history, :last_transition, :transition_to!, :transition_to, :in_state?, to: :state_machine

  def state_machine
    @state_machine ||= StepStateMachine.new(
      self, transition_class: StepTransition, association_name: :transitions
    )
  end
end
