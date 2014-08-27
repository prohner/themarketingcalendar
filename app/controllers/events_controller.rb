class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :edit_event_in_popover]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # GET /new_event_in_popover
  def new_event_in_popover
    @event = Event.new
    @repetition_types = Event.list_of_repetition_type_options
    render :partial => "edit_in_popover", :layout => false
  end

  # GET /edit_event_in_popover/29/edit
  def edit_event_in_popover
    @repetition_types = Event.list_of_repetition_type_options
    render :partial => "edit_in_popover", :layout => false
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        if @event.category.category_group.user != current_user
          CalendarMailer.event_added_by_someone_else(@event).deliver
        end
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :json => @event, status: :created, location: @event }
      else
        # puts @event.errors.inspect
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :json => @event }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:description, :starts_at, :ends_at, :category_id, :repetition_type, :repetition_frequency, :on_sunday, :on_monday, :on_tuesday, :on_wednesday, :on_thursday, :on_friday, :on_saturday, :repetition_options, :notes)
    end
    
end
