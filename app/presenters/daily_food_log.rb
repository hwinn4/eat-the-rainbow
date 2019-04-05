class DailyFoodLog
  def initialize(foods_by_day, user_id, date)
    @foods_by_day = foods_by_day
    @user_id = user_id
    @date = date
  end

  def full_day_log
    all_foods = []

    consumed_colors = @foods_by_day.map(&:color)
    null_colors = Food.colors.keys - consumed_colors

    all_foods.concat(@foods_by_day)
    all_foods.concat(create_null_colors(null_colors))
    all_foods
  end

  def sorted_full_day_log
    @sorted_full_day_log ||= sorted_log
  end

  def has_all_colors?
    sorted_full_day_log.none? { |food| food.is_a? NullFood }
  end

  private

  def create_null_colors(null_colors)
    null_colors.map do |color|
      NullFood.new(color)
    end
  end

  def sorted_log
    sorted_log = []

    full_day_log.each do |food|
      sorted_log[Food.colors[food.color]] = food
    end
    sorted_log
  end
end