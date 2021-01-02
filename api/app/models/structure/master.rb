module Structure
  class Master
    include ActiveModel::Model
    include ActiveModel::Attributes

    def initialize(structure)
      @structure = Structure::Master.parse(structure)
    end

    def structure
      @structure
    end

    def step_names(steps = nil)
      steps ||= structure
      steps.map do |step|
        if step.is_a?(Array)
          self.step_names(step)
        else
          step.name
        end
      end
    end

    def self.parse(steps)
      raise ArgumentError unless steps.is_a?(Array)
      steps.map do |step|
        if step.is_a?(Array)
          parse(step)
        else
          Structure::Step.new(step)
        end
      end
    end
  end
end
