require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'get template for admin' do
      get :new
      expect(response).to render_template :new
    end
  end
  describe 'Authorization and logout of admin user' do
    before(:each) do
      @admin = AdminUser.find_by(id: 1)
    end

    describe 'POST #create' do
      it 'authorize admin user and redirects to the dashboard' do
        post :create, params: { session: { email: 'james095@yandex.ru', password: 'psphuck01' } }
        @admin.authenticate(@admin.password)
        response.should redirect_to root_path
      end
    end

    describe 'DELETE #destroy' do
      it 'logout admin user' do
        delete :destroy, params: { id: @admin.id }
        response.should redirect_to root_path
      end
    end
  end
end
