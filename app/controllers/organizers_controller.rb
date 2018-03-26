class OrganizersController < ApplicationController
    #before_action :user_is_admin, only: [:index, :edit, :update, :destroy]

    def show
      @organizer = Organizer.find(params[:id])
      @events = Event.where(organizer_id: @organizer.id)
    end

    def new
      @organizer = Organizer.new
      @events = @organizer.events
    end

    def create
      @organizer = Organizer.new(organizer_params)
      if @organizer.save
        flash[:success] = "Successfully created!"
        redirect_to @organizer
      else
        render 'new'
      end
    end

    def edit
      @organizer = Organizer.find(params[:id])
    end

    def update
      @organizer = Organizer.find(params[:id])
      if @organizer.update_attributes(organizer_params)
        flash[:success] = "Organizer updated"
        redirect_to @organizer
      else
        render 'edit'
      end
    end

    def destroy
      Organizer.find(params[:id]).destroy
      flash[:success] = "Organizer deleted"
      redirect_to events_url
    end
  
    private
      def organizer_params
        params.require(:organizer).permit(:name, :description, :events)
      end

end

