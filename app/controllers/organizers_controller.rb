class OrganizersController < ApplicationController

  def index
    @organizers = Organizer.paginate(page: params[:page], per_page: 18)
  end

  def show
    @organizer = Organizer.includes(:events).where(id: params[:id]).find(params[:id])
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
    if @organizer.update(organizer_params)
      flash[:success] = 'Организатор успешно изменен'
      redirect_to @organizer
    else
      render 'edit'
    end
  end

  def destroy
    @organizer = Organizer.find(params[:id])
    if @organizer.destroy
      flash[:success] = 'Организатор удален'
      redirect_to organizers_url
    else
      render 'edit'
    end
  end

  private

  def organizer_params
    params.require(:organizer).permit(:name, :description, :events)
  end

  
end
