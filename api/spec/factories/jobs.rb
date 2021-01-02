# == Schema Information
#
# Table name: jobs
#
#  id          :bigint           not null, primary key
#  workflow_id :bigint           not null
#  job_number  :bigint           not null
#  structure   :text(65535)      not null
#  start_at    :datetime
#  end_at      :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_jobs_on_workflow_id                 (workflow_id)
#  index_jobs_on_workflow_id_and_job_number  (workflow_id,job_number) UNIQUE
#
FactoryBot.define do
  factory :job do
    association :workflow
    sequence(:job_number)
    structure { '{}' }
  end
end
