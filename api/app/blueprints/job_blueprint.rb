class JobBlueprint < Blueprinter::Base
  identifier :id

  fields :job_number, :structure, :step_ids
end
