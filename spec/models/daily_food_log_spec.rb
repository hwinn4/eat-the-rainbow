require 'rails_helper'

RSpec.describe DailyFoodLog do
  let(:user) { FactoryBot.create(:user) }
  let(:food1) { FactoryBot.create(:food, color: Food.colors[:brown]) }
  let(:daily_food_log1) { DailyFoodLog.find(food1.id) }

  describe '.full_day_log' do
    it 'returns an array of foods and null foods' do
      return_val = DailyFoodLog.full_day_log(food1.user.id, Date.today)
      expect(return_val.first).to be_a_kind_of(DailyFoodLog)
      expect(return_val.last).to be_a_kind_of(NullFood)
    end
  end

  describe '.sorted_full_day_log' do
    it 'returns an array sorted by enum index' do
      return_val = DailyFoodLog.sorted_full_day_log(food1.user.id, Date.today)
      expect(return_val.first).to be_a_kind_of(NullFood)
      expect(return_val.last).to be_a_kind_of(DailyFoodLog)
    end
  end

  describe '.has_all_colors?' do
    context 'when the users has recorded at least 1 instance of each color' do
      let(:foods) { [mock_model(Food), mock_model(Food)] }
      it 'returns true' do
        expect(DailyFoodLog.has_all_colors?(foods)).to eq(true)
      end
    end

    context 'when the users has not recorded all of the colors' do
      let(:foods) { [mock_model(Food), NullFood.new('blue')] }
      it 'returns false' do
        expect(DailyFoodLog.has_all_colors?(foods)).to eq(false)
      end
    end
  end
end