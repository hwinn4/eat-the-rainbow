class FoodsController < ApplicationController
  def index
    if params[:food]
      date = food_query_params[:date]
    else
      date = Date.today
    end

    @foods = Food.query_by_date(date, current_user.id)
    @colors = Food.colors
    render :index
  end

  def create
    food = Food.new(new_food_params)
    if food.save
      redirect_to 'index'
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