require 'rails_helper'

RSpec.describe Structure::Master, type: :model do
  describe '.initialize' do
    it { expect { Structure::Master.new({}) }.to raise_error(ArgumentError) }
    it { expect { Structure::Master.new(['wrong']) }.to raise_error(ArgumentError) }
  end

  describe '#step_names' do
    let(:structure) do
      [
        { name: 'hogehoge' },
        { name: 'piyopiyo' },
        [
          { name: 'hoge' },
          { name: 'piyo' }
        ]
      ]
    end
    it { expect(Structure::Master.new(structure).step_names).to eq(['hogehoge', 'piyopiyo', ['hoge', 'piyo']]) }
  end
end
