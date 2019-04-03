require 'rails_helper'

RSpec.describe FoodsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryBot.create(:user)
    sign_in user
  end

  describe '#index' do
    let(:foods) { Food.none }
    let(:colors) { Food.colors }

    it 'renders the index view' do
      allow(Food).to receive(:find_daily_log).and_return(foods)
      get :index, params: { food: { date: Date.today } }

      expect(assigns(:foods)).to eq(foods)
      expect(assigns(:colors)).to eq(colors)
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    let(:params) { { date: Date.today, color: 'red' } }
    let(:new_food) { mock_model(Food, save: true) }

    it 'redirects to the index' do
      allow(Food).to receive(:new).and_return(new_food)
      post :create, params: { food: params }

      expect(response).to redirect_to('/foods')
    end
  end
end