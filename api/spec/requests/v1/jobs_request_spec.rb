require 'rails_helper'

RSpec.describe "V1::Jobs", type: :request do
  describe 'create' do
    let(:structure) do
      [
        { name: 'step_1' },
        { name: 'step_2' },
        [
          { name: 'step_3-1' },
          { name: 'step_3-2' }
        ]
      ]
    end
    let(:workflow) { FactoryBot.create(:workflow, structure: structure.to_json) }

    before { post "/v1/workflows/#{workflow.id}/jobs" }

    it { expect(response.status).to eq 200 }
    specify do
      expect(response.body).to be_json.with_content({
        id: Expectations::PositiveNumber,
        job_number: workflow.jobs.order(job_number: :desc).first.job_number,
        step_ids: Expectations::ArrayWithSize[4],
        structure: structure.to_json
      }).at_path('data')
    end
  end
end
