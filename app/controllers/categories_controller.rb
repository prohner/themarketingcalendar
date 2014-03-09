class CategoriesController < ApplicationController
  include ApplicationHelper
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # before_action :verify_user_is_signed_in_or_redirect #, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /categories
  # GET /categories.json
  def index
    @categories = current_user.all_categories
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @color_scheme = ColorScheme.find(@category.color_scheme_id)
  end

  # GET /categories/new
  def new
    @category = Category.new
    @color_scheme = ColorScheme.all.first
  end

  # GET /categories/1/edit
  def edit
    @color_scheme = ColorScheme.find(@category.color_scheme_id)
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
  
  def color_sample
    color_scheme = ColorScheme.find(params[:color_scheme_id])
    s = {
      :example => color_scheme_as_html_snippet_to_display(color_scheme),
      :name => color_scheme.name
    }
    respond_to do |format|
      format.json { render json: s }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:description, :color_scheme_id, :category_group_id)
    end
end
