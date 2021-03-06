class UsersController < ApplicationController
  # before_action :verify_user_is_signed_in_or_redirect, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :root_user, only: [:index, :show, :edit, :udpdate, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
   @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    # puts "creating #{user_params.inspect}"

    respond_to do |format|
      if @user.save_with_payment
        sign_in @user
        flash[:success] = "Welcome!"
        
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def signed_in_user
    set_user
    if current_user.nil? or @user.nil? or current_user.id != @user.id or not signed_in?
      redirect_to signin_url, notice: "Please sign in."
    end
    
  end
  


  private
    # Use callbacks to share common setup or constraints between actions.
    
    def set_user
      @user = User.find(params[:id])
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def root_user
      user_is_a_root_user = false
      if not current_user.nil? and current_user.root?
        user_is_a_root_user = true
      end
      # redirect_to root_url , alert: "You are not permitted to perform this operation!" unless not current_user.nil? && current_user.root?
      unless user_is_a_root_user
        redirect_to root_path, alert: "You are not permitted to perform this operation!"
      end
      
      user_is_a_root_user
    end
  
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :user_type, :email_summary_frequency)
    end
end
