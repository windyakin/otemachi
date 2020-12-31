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
require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should belong_to(:workflow) }
  it { should have_many(:steps) }

  it { should validate_presence_of(:job_number) }
  it { should validate_presence_of(:structure) }
  it { should validate_numericality_of(:job_number).is_greater_than_or_equal_to(1) }
end
