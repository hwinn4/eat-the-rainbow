class DailyFoodLog < ActiveRecord::Base
  self.primary_key = :id
  belongs_to :user

  include ColorEnum

  def self.full_day_log(user_id, date)
    all_foods = []

    consumed_foods = self.foods_by_day(user_id, date)
    consumed_colors = consumed_foods.map(&:color)
    null_colors = Food.colors.keys - consumed_colors

    all_foods.concat(consumed_foods)
    all_foods.concat(create_null_colors(all_foods, null_colors))
    all_foods
  end

  def self.sorted_full_day_log(user_id, date)
    sorted_log = []
    log = full_day_log(user_id, date)

    log.each do |food|
      sorted_log[Food.colors[food.color]] = food
    end
    sorted_log
  end

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end

  private

  def self.create_null_colors(all_foods, null_colors)
    # TODO: What's the best pattern for this? Should this model be coupled to NullFood?
    null_colors.map do |color|
      NullFood.new(color)
    end
  end

  def self.foods_by_day(user_id, date)
    where("date(date) = ? AND user_id = #{user_id}", date)
  end
end