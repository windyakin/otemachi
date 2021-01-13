module V1
  class JobsController < ApplicationController
    def create
      workflow = Workflow.find(jobs_params)
      job_number = workflow.jobs.order(job_number: :asc).first&.job_number || 0
      job = nil
      ApplicationRecord.transaction do
        job = workflow.jobs.create!(job_number: job_number + 1, structure: workflow.structure)
        Step.import(workflow.structure_hash.step_names.flatten.map { |name| job.steps.build(name: name) })
      end
      render json: { data: JobBlueprint.render_as_hash(job.reload) }
    end

    def jobs_params
      @jobs_params ||= params.require(:workflow_id)
    end
  end
end
