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
require 'rails_helper'

RSpec.describe Step, type: :model do
  it { should belong_to(:job) }

  it { should validate_presence_of(:name) }
end
