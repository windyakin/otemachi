module Structure
  class Step
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :name, :string

    validates_presence_of :name

    def as_json(options = nil)
      self.attribute_names.map { |key_name| [ key_name, self.send(key_name) ] }.to_h
    end
  end
end
