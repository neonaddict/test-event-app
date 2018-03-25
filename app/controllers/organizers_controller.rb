class OrganizersController < ApplicationController
    #before_action :user_is_admin, only: [:index, :edit, :update, :destroy]

    def show
      @organizer = Organizer.find(params[:id])
    end

    def new
      @organizer = Organizer.new
    end

    def create
      @organizer = Organizer.new(event_params)
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
      if @organizer.update_attributes(event_params)
        flash[:success] = "Organizer updated"
        redirect_to @organizer
      else
        render 'edit'
      end
    end

    def destroy
      Event.find(params[:id]).destroy
      flash[:success] = "Organizer deleted"
      redirect_to events_url
    end
  
    private
      def event_params
        params.require(:event).permit(:name, :description)
      end

end

