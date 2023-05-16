class EventsController < ApplicationController
  before_action :authenticate_user, only: [:show, :edit, :create, :new, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(title: params[:title], description: params[:description], start_date: params[:start_date], duration: params[:duration], price: params[:price], location: params[:location], admin: current_user)
    
    if @event.save
      flash[:success] = "L'évènement a bien été créé !"
      redirect_to '/'
    else
      render :new
    end
  end  
  
  def index
    @events = Event.all
    @events = Event.order(updated_at: :desc) 
  end

  def show
    @events = Event.all
    @event = Event.find(params[:id])
    @user = @event.admin
  end

  def edit
    @event = Event.find(params[:id])
    redirect_to root_path unless current_user == @event.user
  end
  
  def update
    @event = Event.find(params[:id])
    if current_user == @event.user && @event.update(title: params[:title], content: params[:content])
      flash[:success] = "L'évènement a été modifié avec succès."
      redirect_to event_path(params[:id])
    else
      render :edit
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    if current_user == @event.user && @event.destroy
      flash[:success] = "L'évènement a été détruit avec succès."
      redirect_to events_path
    else
      flash[:error] = "L'évènement n'a pas été détruit."
      redirect_to event_path(params[:id])
    end
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_user_registration_path
    end
  end
end
