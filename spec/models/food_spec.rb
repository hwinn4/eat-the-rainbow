require 'rails_helper'

RSpec.describe Food do
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:color) }
  it { should define_enum_for(:color) }

  describe '.query_by_date' do
    it 'queries active record for the foods belonging to the given user on the given date' do
      expect(Food).to receive(:where).with('date = ? AND user_id = ?', Date.today, 1).and_return(Food.none)

      Food.query_by_date(Date.today, 1)
    end
  end
end