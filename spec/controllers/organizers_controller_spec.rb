require 'rails_helper'
include SessionsHelper

RSpec.describe OrganizersController, type: :controller do
  describe 'GET #index' do
    it 'populates an array of organizers with pagination' do
      organizers = Organizer.paginate(page: 1, per_page: 18)
      get :index, params: { page: 1 }
      assigns(:organizers).should eq(organizers)
    end

    it 'renders the :index view' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    id = 3
    it 'assigns the requested event to @organizer' do
      organizer = Organizer.find_by(id: id)
      get :show, params: { id: organizer.id }
      assigns(:organizer).should eq(organizer)
    end

    it 'renders the :show template' do
      get :show, params: { id: id }
      response.should render_template :show
    end
  end

  describe 'GET #new if not logged' do
    it 'redirect to index and flash if not logged in' do
      get :new
      expect(response).to redirect_to(root_path)
      expect(flash[:danger]).to be_present
    end
  end

  describe 'if admin logged in' do
    before(:each) do
      @organizer = Organizer.last
      @admin = AdminUser.find_by(id: 1)
      @organizer_params = { name: 'Владимир Путин', description: 'smth' }
      @nil_params = { name: '' }
      log_in(@admin)
    end

    describe 'GET #new' do
      it 'assigns a new Organizer to @organizer' do
        log_in(@admin)
        get :new
        expect(assigns(:organizer)).to be_a_new(Organizer)
      end

      it 'renders the :new template' do
        log_in(@admin)
        get :new
        response.should render_template :new
      end
    end

    describe 'GET #edit' do
      it 'get edit page' do
        get :edit, params: { id: @organizer.id }
        response.should render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new organizer in the database and redirects to event' do
          expect { post :create, params: { organizer: @organizer_params } }.to change(Organizer, :count).by(1)
          response.should redirect_to(action: :show, id: assigns(:organizer).id)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new organizer in the database' do
          expect { post :create, params: { organizer: @nil_params } }.to_not change(Organizer, :count)
        end
        it 're-renders the :new template' do
          post :create, params: { organizer: @nil_params }
          response.should render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      it 'updates event in the database and redirects to event' do
        expect { patch :create, params: { organizer: @organizer_params } }.to change(Organizer, :count).by(1)
        response.should redirect_to(action: :show, id: assigns(:organizer).id)
      end
    end

    describe 'DELETE #destroy' do
      it 'delete event in the database and redirects to index' do
        log_in(@admin)
        expect { delete :destroy, params: { id: @organizer.id } }.to change(Organizer, :count).by(-1)
        response.should redirect_to organizers_path
      end
    end
  end
end
