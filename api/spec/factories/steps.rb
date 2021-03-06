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
FactoryBot.define do
  factory :step do
    association :job
    sequence(:name) { |n| "step_#{n}" }
  end
end
