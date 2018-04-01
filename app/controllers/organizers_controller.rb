class OrganizersController < ApplicationController
  before_action :admin_is_logged_in, only: %i[new edit update destroy]

  def index
    @organizers = Organizer.paginate(page: params[:page], per_page: 18)
  end

  def show
    @organizer = Organizer.find_by(id: params[:id])
    @events = Event.where(organizer_id: @organizer.id).order(date: :desc)
  end

  def new
    @organizer = Organizer.new
    @events = @organizer.events
  end

  def create
    @organizer = Organizer.new(organizer_params)
    if @organizer.save
      flash[:success] = 'Организатор успешно создан!'
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
      flash[:success] = 'Организатор успешно изменен'
      redirect_to @organizer
    else
      render 'edit'
    end
  end

  def destroy
    Organizer.find(params[:id]).destroy
    flash[:success] = 'Организатор удален'
    redirect_to organizers_url
  end

  private

  def organizer_params
    params.require(:organizer).permit(:name, :description, :events)
  end

  # Confirms that admin is logged in.
  def admin_is_logged_in
    unless logged_in?
      flash[:danger] = 'Доступ закрыт'
      redirect_to root_url
    end
  end
end
