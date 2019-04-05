require 'rails_helper'

RSpec.describe DateHelper do
  let(:klass) { Class.new { include DateHelper } }

  subject { klass.new }

  describe '#string_to_date' do
    context 'when given a string' do
      it 'returns the date in mm/dd/yyyy format' do
        expect(subject.string_to_date('3/1/2019')).to eq(Date.new(2019,3,1))
        expect(subject.string_to_date('2019-3-1')).to eq(Date.new(2019,3,1))
      end
    end
  end

  describe '#date_to_string' do
    it 'returns the date in mm/dd/yyyy format' do
      expect(subject.date_to_string(Date.new(2001,2,3))).to eq('02/03/2001')
    end
  end

  describe '#index_date' do
    context 'when the date is the default date (today)' do
      it 'returns the date in the mm/dd/yyyy format' do
        expect(subject.index_date(Date.today)).to eq(Date.today.strftime('%m/%d/%Y'))
      end
    end

    context 'when the date is submitted by the user in mm/dd/yyyy format' do
      it 'returns the date as-is' do
        expect(subject.index_date('04/04/2019')).to eq('04/04/2019')
      end
    end
  end
end