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
FactoryBot.define do
  factory :workflow do
    sequence(:name) { |n| "workflow_#{n}" }
    structure { '{}' }
  end
end
