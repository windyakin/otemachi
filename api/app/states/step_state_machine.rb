class StepStateMachine
  include Statesman::Machine

  state :ready, initial: true
  state :running
  state :finished
  state :cancelled
  state :succeeded
  state :failed
  state :warned

  transition from: :ready, to: [:running, :cancelled]
  transition from: :running, to: [:finished, :succeeded, :failed, :warned, :cancelled]
  transition from: :finished, to: [:succeeded, :failed, :warned]

  before_transition(from: :ready, to: [:running, :cancelled]) do |step|
    step.start_at = Time.zone.now
  end

  before_transition(from: :running, to: [:finished, :succeeded, :failed, :warned]) do |step|
    step.end_at = Time.zone.now
  end
end
