class ShareController < ApplicationController
  before_action :assign_share
  before_action :signed_in

  def edit
  end

  def destroy
    @share.destroy
    respond_to do |format|
      format.html { redirect_to category_groups_path, notice: "#{@share.partner.full_name} no longer has access to #{@share.category_group.description}." }
    end
  end
  
  def update
    @share.user_type = params[:share][:user_type]
    puts @share.inspect
    respond_to do |format|
      if @share.save
        format.html { redirect_to category_groups_path, notice: "#{@share.partner.full_name} is now #{User.description_for_user_type(@share.user_type)} on #{@share.category_group.description}." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def signed_in
    unless not current_user.nil? and current_user.id == @share.owner_id
      redirect_to signin_path
    end
  end
  
  private
    def assign_share
      @share = Share.find(params[:id])
    end
  
    def user_params
      params.require(:share).permit(:id, :user_type)
    end
end
