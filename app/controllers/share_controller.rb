class ShareController < ApplicationController
  before_action :assign_share
  before_action :signed_in

  def edit
  end

  def destroy
    @share.destroy
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
      params.require(:share).permit(:id)
    end
end
