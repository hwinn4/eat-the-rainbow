require 'rails_helper'

RSpec.describe DailyFoodLog do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, color: Food.colors[:brown]) }
  let(:food_by_day) { [FoodByDay.find(food.id)] }

  subject { DailyFoodLog.new(food_by_day, user.id, Date.today) }

  describe '.full_day_log' do
    it 'returns an array of foods and null foods' do
      return_val = subject.full_day_log
      expect(return_val.first).to be_a_kind_of(FoodByDay)
      expect(return_val.last).to be_a_kind_of(NullFood)
    end
  end

  describe '.sorted_full_day_log' do
    it 'returns an array sorted by enum index' do
      return_val = subject.sorted_full_day_log
      expect(return_val.first).to be_a_kind_of(NullFood)
      expect(return_val.last).to be_a_kind_of(FoodByDay)
    end
  end

  describe '.has_all_colors?' do
    let(:food_by_day) { [] }
    let(:food) do
      Food.colors.each do |c|
        food = FactoryBot.create(:food, color: Food.colors[c.first])
        food_by_day << FoodByDay.find(food.id)
      end
    end

    context 'when the users has recorded at least 1 instance of each color' do
      it 'returns true' do
        allow(subject).to receive(:sorted_full_day_log).and_return(food_by_day)
        expect(subject.has_all_colors?).to eq(true)
      end
    end

    context 'when the users has not recorded all of the colors' do
      it 'returns false' do
        expect(subject.has_all_colors?).to eq(false)
      end
    end
  end
end