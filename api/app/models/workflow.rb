# == Schema Information
#
# Table name: workflows
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  structure  :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Workflow < ApplicationRecord
  has_many :jobs

  validates_presence_of :name
  validates_presence_of :structure

  validate :valid_structure_json_format

  def valid_structure_json_format
    begin
      structure_hash
    rescue JSON::ParserError
      errors.add(:structure, 'Invalid JSON format')
    end
  end

  def structure_hash
    JSON.parse(structure || '{}')
  end
end
