class FoodsController < ApplicationController
  def index
    if params[:food]
      date = food_query_params[:date]
    else
      date = Date.today
    end

    @foods = Food.find_daily_log(date, current_user.id)
    @colors = Food.colors

    render :index
  end

  def create
    food = current_user.foods.build(new_food_params)
    # TODO: Else!
    if food.save
      # TODO: Use render or redirect_to?
      redirect_to '/foods'
    end
  end

  private
  def food_query_params
    params.require(:food).permit(:date)
  end

  def new_food_params
    params.require(:food).permit(:date, :color)
  end
end