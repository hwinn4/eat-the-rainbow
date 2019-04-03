require 'rails_helper'

RSpec.describe FoodsController do
  describe '#index' do
    it 'returns foods by date' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      get :index

      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end
end