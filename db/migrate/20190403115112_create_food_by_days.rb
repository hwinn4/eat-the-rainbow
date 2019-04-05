class CreateFoodByDays < ActiveRecord::Migration[5.2]
  def change
    create_view :food_by_days
  end
end
