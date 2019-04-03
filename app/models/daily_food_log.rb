class DailyFoodLog < ActiveRecord::Base
  self.primary_key = :id
  belongs_to :user

  include ColorEnum

  def self.foods_by_day(user_id, date)
    where("date(date) = ? AND user_id = #{user_id}", date)
  end

  def self.full_day_log(user_id, date)
    # TODO: Test!
    all_foods = []

    consumed_foods = self.foods_by_day(user_id, date)
    all_foods << consumed_foods.to_a

    consumed_colors = consumed_foods.map(&:color)
    null_colors = Food.colors.keys - consumed_colors

    all_foods << create_null_colors(all_foods, null_colors)

    all_foods.flatten
  end

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end

  private

  def self.create_null_colors(all_foods, null_colors)
    null_colors.map do |color|
      NullFood.new
    end
  end
end