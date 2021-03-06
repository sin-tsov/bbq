class EventsController < ApplicationController
  before_action :authenticate_user!, expect: [:show, :index]
  before_action :set_event, only: [:show]
  before_action :set_current_user_event, only: [:edit, :update, :destroy]

 
  def index
    @events = Event.all
  end

 
  def show
  end

 
  def new
    @event = current_user.events.build
  end

  def edit
  end


  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_current_user_event
      @event = current_user.events.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:id])
    end

   
    def event_params
      params.require(:event).permit(:title, :address, :datetime, :description)
    end
end
