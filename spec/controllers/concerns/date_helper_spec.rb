require 'rails_helper'

RSpec.describe DateHelper do
  let(:klass) { Class.new { include DateHelper } }

  subject { klass.new }

  # TODO: Use in create
  describe '#string_to_date' do
    context 'when given a string' do
      it 'returns the date in mm/dd/yyyy format' do
        expect(subject.string_to_date('2019-03-01')).to eq(Date.new(2019,3,1))
      end
    end
  end

  # TODO: Use in index
  describe '#date_to_string' do
    it 'returns the date in mm/dd/yyyy format' do
      expect(subject.date_to_string(Date.new(2001,2,3))).to eq('02/03/2001')
    end
  end
end