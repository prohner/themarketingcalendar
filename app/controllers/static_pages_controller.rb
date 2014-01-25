class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
  
  def interested
    @ip = InterestedParty.new(:email => params[:email])
    
    UserMailer.thank_you_interested_party(@ip.email, root_path).deliver
    if @ip.save
      flash[:success] = "How cool are you?!?  We're excited and we'll drop you a note at #{params[:email]} when it's ready."
    else
      flash[:error] = "Something went wrong...argh...we didn't get to save your email."
    end
    
    redirect_to request.referer
  end
end
