require 'rails_helper'

RSpec.describe FoodsController do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe '#index' do
    let(:foods) { double(ActiveRecord::Relation, find_by_date: nil) }
    let(:colors) { Food.colors }

    it 'renders the index view' do
      allow(user).to receive(:daily_food_logs).and_return(foods)
      get :index, params: { food: { date: Date.today } }

      expect(assigns(:foods)).to eq([])
      expect(assigns(:colors)).to eq(colors)
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    let(:params) { { date: Date.today, color: 'red' } }
    let(:new_food) { mock_model(Food, save: true) }

    it 'redirects to the foods index' do
      allow(user).to receive(:foods).and_return(Food.none)
      allow(Food.none).to receive(:build).with(params).and_return(new_food)
      post :create, params: { food: params }

      expect(response).to redirect_to('/foods')
    end
  end
end