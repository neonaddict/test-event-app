require 'rails_helper'
require 'will_paginate/array'
include SessionsHelper

RSpec.describe EventsController, type: :controller do
  describe 'GET #index' do
    it 'populates an array of events with pagination' do
      events = Event.paginate(page: 1, per_page: 18).order('date DESC')
      get :index, params: { page: 1 }
      assigns(:events).should eq(events)
    end

    it 'renders the :index view' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do
    id = 3
    it 'assigns the requested event to @event and organizer for @event' do
      event = Event.find_by(id: id)
      organizer = Organizer.find_by(id: event.organizer_id)
      get :show, params: { id: event.id }
      assigns(:event).should eq(event)
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
      @event = Event.last
      @admin = AdminUser.find_by(id: 1)
      @event_params = { name: 'JS Meetup', city: 'Ростов-на-Дону',
                        address: 'Каяни 14', date: DateTime.now, organizer_id: 1,
                        description: 'smth', link: 'https://google.com' }
      @nil_params = { name: '' }
      log_in(@admin)
    end

    describe 'GET #new' do
      it 'assigns a new Event to @event' do
        log_in(@admin)
        get :new
        expect(assigns(:event)).to be_a_new(Event)
      end

      it 'renders the :new template' do
        log_in(@admin)
        get :new
        response.should render_template :new
      end
    end

    describe 'GET #edit' do
      it 'get edit page' do
        get :edit, params: { id: @event.id }
        response.should render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new event in the database and redirects to event' do
          expect { post :create, params: { event: @event_params } }.to change(Event, :count).by(1)
          response.should redirect_to(action: :show, id: assigns(:event).id)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new event in the database' do
          expect { post :create, params: { event: @nil_params } }.to_not change(Event, :count)
        end
        it 're-renders the :new template' do
          post :create, params: { event: @nil_params }
          response.should render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      it 'updates event in the database and redirects to event' do
        expect { patch :create, params: { event: @event_params } }.to change(Event, :count).by(1)
        response.should redirect_to(action: :show, id: assigns(:event).id)
      end
    end

    describe 'DELETE #destroy' do
      it 'delete event in the database and redirects to index' do
        log_in(@admin)
        expect { delete :destroy, params: { id: @event.id } }.to change(Event, :count).by(-1)
        response.should redirect_to events_path
      end
    end
  end
end
