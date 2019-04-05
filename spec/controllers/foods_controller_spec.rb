require 'rails_helper'
include DateHelper

RSpec.describe FoodsController do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe '#index' do
    let(:foods) { double(ActiveRecord::Relation, find: []) }
    let(:colors) { Food.colors }
    let(:daily_food_log_double) { double('daily food log', sorted_full_day_log: [], has_all_colors?: false) }

    it 'renders the index view' do
      allow(FoodByDay).to receive(:search).and_return(FoodByDay.none)
      allow(DailyFoodLog).to receive(:new).and_return(daily_food_log_double)

      get :index, params: { food: { date: Date.today } }

      expect(assigns(:foods)).to eq([])
      expect(assigns(:should_celebrate)).to eq(false)
      expect(assigns(:colors)).to eq(colors)
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    let(:date_string) { '03/04/2019' }
    let(:date) { string_to_date(date_string) }
    let(:params) { { date: date, color: 'red' } }
    let(:new_food) { mock_model(Food, save: true, date: date) }

    it 'redirects to the foods index' do
      allow(user).to receive(:foods).and_return(Food.none)
      allow(Food.none).to receive(:build).with(params).and_return(new_food)
      post :create, params: { food: params }

      expect(response).to redirect_to("/foods?food[date]=#{date_string}")
    end
  end

  describe '#destroy' do
    it 'removes the specified record from the database' do
      expect(Food).to receive(:destroy).with('1')
      delete :destroy, params: { id: 1, food: { date: '3/4/2019' } }
    end
  end
end