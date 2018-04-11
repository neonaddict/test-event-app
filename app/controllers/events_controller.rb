class EventsController < ApplicationController
  
  def index
    @events = Event.paginate(page: params[:page], per_page: 18).order('date DESC')
  end

  def show
    @event = Event.includes(:organizer).find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = 'Мероприятие успешно создано!'
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
    if @event.update(event_params)
      flash[:success] = 'Мероприятие изменено'
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = 'Мероприятие удалено'
      redirect_to events_url
    else
      render 'index'
    end
  end

  def ics
    @event = Event.find(params[:id])
    send_data @event.ics_create.to_ical, type: 'text/calendar', disposition: 'attachment',
      filename: "#{@event.name}.ics"
  end

  def subscribe
    flash[:success] = "Успешно подписаны на напоминания! #{params[:email]}"
    SendEmailWorker.perform_async(params[:email], params[:id])
  end

  # For filters use scopes, defined in event.rb
  def filter
    @events = Event.filter(filter_params).paginate(page: params[:page], per_page: 18)
    if @events.blank?
      flash.now[:warning] = 'Извините, ничего не найдено по вашему запросу :('
    end
    render 'index'
  end

  private

  def event_params
    params.require(:event).permit(:name, :city, :address,
                                  :date, :organizer_id, :description, :link, :event_image)
  end

  def filter_params
    params.permit(:city, :month, :organizer_id, :par)
  end

  
end
