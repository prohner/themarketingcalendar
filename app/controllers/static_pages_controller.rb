class StaticPagesController < ApplicationController
  def home
  end

  def home2
    render :layout => false
  end

  def help
  end

  def about
  end

  def contact
  end

  def whats_in_it_for_me
  end
  
  def pricing
  end

  def our_technology
  end
  
  def interested
    @ip = InterestedParty.new(:email => params[:email])
    
    UserMailer.thank_you_interested_party(@ip.email, root_url).deliver
    if @ip.save
      flash[:success] = "How cool are you?!?  We're excited and we'll drop you a note at #{params[:email]} when it's ready."
    else
      flash[:error] = "Something went wrong...argh...we didn't get to save your email."
    end
    
    redirect_to "#{request.referer}?ip=y"
  end
  
  def contact_help
    @help_request = HelpRequest.new(:email => params[:email], :subject => params[:subject], :description => params[:description])
    UserMailer.contact_help(@help_request).deliver
    
    if @help_request.save
      flash[:success] = "Thank you for contacting us.  We will email you back just as soon as we can."
    else
      flash[:error] = "Something went wrong while saving your request to the database.  It was emailed anyway so expect us to email you back."
    end
    
    redirect_to "#{request.referer}?ip=y"
    
  end
end
