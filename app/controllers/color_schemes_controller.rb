class ColorSchemesController < ApplicationController
  before_action :set_color_scheme, only: [:show, :edit, :update, :destroy]

  # GET /color_schemes
  # GET /color_schemes.json
  def index
    @color_schemes = ColorScheme.all
  end

  # GET /color_schemes/1
  # GET /color_schemes/1.json
  def show
  end

  # GET /color_schemes/new
  def new
    @color_scheme = ColorScheme.new
  end

  # GET /color_schemes/1/edit
  def edit
  end

  # POST /color_schemes
  # POST /color_schemes.json
  def create
    @color_scheme = ColorScheme.new(color_scheme_params)

    respond_to do |format|
      if @color_scheme.save
        format.html { redirect_to @color_scheme, notice: 'Color scheme was successfully created.' }
        format.json { render action: 'show', status: :created, location: @color_scheme }
      else
        format.html { render action: 'new' }
        format.json { render json: @color_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /color_schemes/1
  # PATCH/PUT /color_schemes/1.json
  def update
    respond_to do |format|
      if @color_scheme.update(color_scheme_params)
        format.html { redirect_to @color_scheme, notice: 'Color scheme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @color_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /color_schemes/1
  # DELETE /color_schemes/1.json
  def destroy
    @color_scheme.destroy
    respond_to do |format|
      format.html { redirect_to color_schemes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color_scheme
      @color_scheme = ColorScheme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_scheme_params
      params.require(:color_scheme).permit(:name, :foreground, :background)
    end
end
