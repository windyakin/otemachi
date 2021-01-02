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

  context 'transitions' do
    describe 'from ready' do
      subject { FactoryBot.create(:step) }
      it 'to running then insert time in start_at' do
        travel_to(Time.zone.now) do
          expect { subject.transition_to!(:running) }.to change { subject.start_at }.from(nil).to(Time.zone.now)
        end
      end
      it 'to cancelled then not insert time in start_at' do
        travel_to(Time.zone.now) do
          expect { subject.transition_to!(:cancelled) }.to change { subject.start_at }.from(nil).to(Time.zone.now)
        end
      end
    end

    describe 'from running' do
      subject { FactoryBot.create(:step) }
      before { subject.transition_to!(:running) }
      it 'to finished then insert time in end_at' do
        travel_to(Time.zone.now) do
          expect { subject.transition_to!(:finished) }.to change { subject.end_at }.from(nil).to(Time.zone.now)
        end
      end
      it 'to succeeded then insert time in end_at' do
        travel_to(Time.zone.now) do
          expect { subject.transition_to!(:succeeded) }.to change { subject.end_at }.from(nil).to(Time.zone.now)
        end
      end
      it 'to failed then insert time in end_at' do
        travel_to(Time.zone.now) do
          expect { subject.transition_to!(:failed) }.to change { subject.end_at }.from(nil).to(Time.zone.now)
        end
      end
      it 'to warned then insert time in end_at' do
        travel_to(Time.zone.now) do
          expect { subject.transition_to!(:warned) }.to change { subject.end_at }.from(nil).to(Time.zone.now)
        end
      end
      it 'to cancelled then not insert time in end_at' do
        travel_to(Time.zone.now) do
          expect { subject.transition_to!(:cancelled) }.not_to change { subject.end_at }.from(nil)
        end
      end
    end
  end
end
