class FoodsController < ApplicationController
  def index
    if params[:food]
      @date = format_date(food_query_params[:date])
    else
      @date = Date.today
    end

    @foods = DailyFoodLog.sorted_full_day_log(current_user.id, @date)
    @colors = Food.colors

    render :index
  end

  def create
    format_date(new_food_params[:date])
    food = current_user.foods.build(new_food_params)
    # TODO: Else!
    if food.save
      # TODO: Use render or redirect_to?
      redirect_to "/foods?food[date]=#{new_food_params[:date]}"
    end
  end

  private
  def food_query_params
    params.require(:food).permit(:date)
  end

  def new_food_params
    params.require(:food).permit(:date, :color)
  end

  def format_date(date)
    begin
      Date.strptime(date, '%m/%d/%Y')
    rescue
      Date.strptime(date, '%Y-%m-%d')
    end
  end
end