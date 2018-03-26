class EventsController < ApplicationController
    #before_action :user_is_admin, only: [:index, :edit, :update, :destroy]

    def index
      @events= Event.paginate(page: params[:page]).order('date DESC')
      #@events = Event.all
    end

    def show
      @event = Event.find(params[:id])
      @organizer = Organizer.find(@event.organizer_id)
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      if @event.save
        flash[:success] = "Successfully created!"
        redirect_to @event
      else
        render 'new'
      end
    end

    def edit
      @event = Event.find(params[:id])
    end

    def update
      @event = Event.find(params[:id])
      if @event.update_attributes(event_params)
        flash[:success] = "Event updated"
        redirect_to @event
      else
        render 'edit'
      end
    end

    def destroy
      Event.find(params[:id]).destroy
      flash[:success] = "Event deleted"
      redirect_to events_url
    end
  
    private
      def event_params
        params.require(:event).permit(:name, :region, :city, :address,
             :date, :organizer_id, :description, :link
             )
      end

end
