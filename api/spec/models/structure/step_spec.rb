require 'rails_helper'

RSpec.describe Structure::Step, type: :model do
  it { should validate_presence_of(:name) }
end
