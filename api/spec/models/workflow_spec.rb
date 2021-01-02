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
require 'rails_helper'

RSpec.describe Workflow, type: :model do
  it { should have_many(:jobs) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:structure) }

  describe ':valid_structure_json_format' do
    it { should allow_value('{}').for(:structure) }
    it { should allow_value('[]').for(:structure) }
    it { should allow_value('{"example": "JSON format"}').for(:structure) }
    it { should_not allow_value('{invalid: "JSON format"}').for(:structure) }
  end
end
