class FoodsController < ApplicationController
  include DateHelper

  def index
    date = params[:food] ? food_query_params[:date] : Date.today
    @date = index_date(date)

    log = build_food_log
    @foods = log.sorted_full_day_log
    @should_celebrate = log.has_all_colors?
    @colors = Food.colors

    render :index
  end

  def create
    params['food']['date'] = string_to_date(new_food_params[:date])
    food = current_user.foods.build(new_food_params)
    food.save
    redirect_to "/foods?food[date]=#{date_to_string(food.date)}"
  end

  def destroy
    Food.destroy(params[:id])
    redirect_to "/foods?food[date]=#{food_query_params[:date]}"
  end

  private

  def build_food_log
    foods = FoodByDay.search(current_user.id, @date)
    DailyFoodLog.new(foods, current_user.id, @date)
  end

  def food_query_params
    params.require(:food).permit(:date)
  end

  def new_food_params
    params.require(:food).permit(:date, :color)
  end
end