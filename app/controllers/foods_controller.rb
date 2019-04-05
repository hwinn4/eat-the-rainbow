class FoodsController < ApplicationController
  include DateHelper

  def index
    @date = params[:food] ? food_query_params[:date] : date_to_string(Date.today)

    @foods = DailyFoodLog.sorted_full_day_log(current_user.id, @date)
    @should_celebrate = @foods.none? { |food| food.is_a? NullFood }
    @colors = Food.colors

    render :index
  end

  def create
    params['food']['date'] = string_to_date(new_food_params[:date])
    food = current_user.foods.build(new_food_params)
    # TODO: Else! 
    if food.save
      # TODO: Use render or redirect_to?
      redirect_to "/foods?food[date]=#{new_food_params[:date]}"
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