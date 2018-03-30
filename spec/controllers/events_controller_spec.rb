require 'rails_helper'
require 'will_paginate/array'

RSpec.describe EventsController, type: :controller do
    describe "GET index" do
        it "renders the index template" do
          get :index
          expect(response).to render_template("index")
        end
        
        events = Event.all 
        it "should have pagination bar and paginate" do
          assign(:events, events.paginate(page:1, per_page: 30))
          render
 
          expect(rendered).to have_selector("ul.pagination")
        end
    end
end
