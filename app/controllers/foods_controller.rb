class FoodsController < ApplicationController
  include DateHelper

  def index
    date = params[:food] ? food_query_params[:date] : Date.today
    @date = index_date(date)

    foods = FoodByDay.search(current_user.id, @date)
    log = DailyFoodLog.new(foods, current_user.id, @date)
    @foods = log.sorted_full_day_log
    @should_celebrate = log.has_all_colors?
    @colors = Food.colors

    render :index
  end

  def create
    params['food']['date'] = string_to_date(new_food_params[:date])
    food = current_user.foods.build(new_food_params)
    # TODO: Else!
    if food.save
      # TODO: Use render or redirect_to?
      redirect_to "/foods?food[date]=#{date_to_string(food.date)}"
    end
  end

  def destroy
    Food.destroy(params[:id])
    redirect_to "/foods?food[date]=#{food_query_params[:date]}"
  end

  private
  def food_query_params
    params.require(:food).permit(:date)
  end

  def new_food_params
    params.require(:food).permit(:date, :color)
  end
end