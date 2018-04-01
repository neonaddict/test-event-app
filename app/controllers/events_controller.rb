class EventsController < ApplicationController
  before_action :admin_is_logged_in, only: %i[new edit update destroy]

  def index
    @events = Event.paginate(page: params[:page], per_page: 18).order('date DESC')
  end

  def show
    if params[:id].to_i != 0
      @event = Event.find_by(id: params[:id])
      @organizer = Organizer.find_by(id: @event.organizer_id)
    else
      redirect_to root_path
    end
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
    @event = Event.find_by(id: params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = 'Мероприятие изменено'
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    puts params.inspect
    Event.find_by(id: params[:id]).destroy
    flash[:success] = 'Мероприятие удалено'
    redirect_to events_url
  end

  def ics
    @event = Event.find_by(id: params[:id])
    ics_create(@event)
  end

  def subscribe
    flash[:success] = "Успешно подписаны на напоминания! #{params[:email]}"
    SendEmailWorker.perform_async(params[:email], params[:id])
    redirect_back fallback_location: root_path
  end

  #def past
  #  @events = Event.where('date < ?', DateTime.now).paginate(page: params[:page]).order('date DESC')
  #  render 'index'
  #end

  #def upcoming
  #  @events = Event.where('date > ?', DateTime.now).paginate(page: params[:page]).order('date DESC')
  #  render 'index'
  #end

  def filter
    @events = Event.city_filter(params[:city]).month_filter(params[:month]).organizer_filter(params[:organizer_id])
    .past_or_upcoming_filter(params[:par]).paginate(page: params[:page], per_page: 18).order('date DESC')
    if @events.blank?
      flash.now[:warning] = 'Извините, ничего не найдено по вашему запросу :('
    end
    render 'index'
  end

  private

  def event_params
    params.require(:event).permit(:name, :region, :city, :address,
                                  :date, :organizer_id, :description, :link, :event_image)
  end

  # Confirms that admin is logged in.
  def admin_is_logged_in
    unless logged_in?
      flash[:danger] = 'Please log in.'
      redirect_to root_url
    end
  end
end
