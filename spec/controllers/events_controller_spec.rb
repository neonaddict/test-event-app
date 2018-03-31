require 'rails_helper'
require 'will_paginate/array'
include SessionsHelper

environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")

def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}.png"))
end

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    it "populates an array of events with pagination" do
      events = Event.paginate(page: 1, per_page: 18).order('date DESC')
      get :index, params: {page: 1}
      assigns(:events).should eq(events)
    end
    
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  
  describe "GET #show" do
    id = 3
    it "assigns the requested event to @event and organizer for @event" do
      event = Event.find_by(id: id)
      organizer = Organizer.find_by(id: event.organizer_id)
      get :show, params: {id: event.id}
      assigns(:event).should eq(event)
      assigns(:organizer).should eq(organizer)
    end

    it "renders the :show template" do
      get :show, params: {id: id}
      response.should render_template :show
    end
  end
  
  describe "GET #new if logged" do
      admin = AdminUser.find_by(id: 1)
    it "assigns a new Event to @event if logged in" do
      log_in(admin)
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end

    it "renders the :new template if logged in" do
      log_in(admin)
      get :new
      response.should render_template :new
    end
  end

  describe "GET #new if not logged" do
    it "redirect to index and flash if not logged in" do
      get :new
      expect(response).to redirect_to(root_path)
      expect(flash[:danger]).to be_present
    end
  end
  
  describe "POST #create" do
    admin = AdminUser.find_by(id: 1)
    context "with valid attributes" do
      it "saves the new event in the database" do
        log_in(admin)  
        expect{
            post :create, params: { event: { name:'JS Meetup', city: 'Ростов-на-Дону', 
              address: 'Каяни 14', date: DateTime.now, organizer_id: 1, 
              description:'smth', link: 'https://google.com', event_image: 'missing')}}
        }.to change(Event,:count).by(1)
      end
      it "redirects to the event page"
    end
    
    context "with invalid attributes" do
      it "does not save the new contact in the database"
      it "re-renders the :new template"
    end
  end
end


