class CreateDailyFoodLogs < ActiveRecord::Migration[5.2]
  def change
    create_view :daily_food_logs
  end
end
