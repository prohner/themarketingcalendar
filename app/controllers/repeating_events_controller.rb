class RepeatingEventsController < ApplicationController
  before_action :set_repeating_event, only: [:show, :edit, :update, :destroy]

  # GET /repeating_events
  # GET /repeating_events.json
  def index
    @repeating_events = RepeatingEvent.all
  end

  # GET /repeating_events/1
  # GET /repeating_events/1.json
  def show
  end

  # GET /repeating_events/new
  def new
    @repeating_event = RepeatingEvent.new
  end

  # GET /repeating_events/1/edit
  def edit
  end

  # POST /repeating_events
  # POST /repeating_events.json
  def create
    @repeating_event = RepeatingEvent.new(repeating_event_params)

    respond_to do |format|
      if @repeating_event.save
        format.html { redirect_to @repeating_event, notice: 'Repeating event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @repeating_event }
      else
        format.html { render action: 'new' }
        format.json { render json: @repeating_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repeating_events/1
  # PATCH/PUT /repeating_events/1.json
  def update
    respond_to do |format|
      if @repeating_event.update(repeating_event_params)
        format.html { redirect_to @repeating_event, notice: 'Repeating event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @repeating_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repeating_events/1
  # DELETE /repeating_events/1.json
  def destroy
    @repeating_event.destroy
    respond_to do |format|
      format.html { redirect_to repeating_events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repeating_event
      @repeating_event = RepeatingEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repeating_event_params
      params.require(:repeating_event).permit(:title, :starts_at, :ends_at, :all_day, :description, :repetition_type, :repetition_frequency, :on_sunday, :on_monday, :on_tuesday, :on_wednesday, :on_thursday, :on_friday, :on_saturday)
    end
end
