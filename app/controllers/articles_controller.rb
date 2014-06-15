class ArticlesController < ApplicationController
  layout 'articles_layout'
  
  def implementation_of_a_marketing_plan
    @title = "Implementation of a Marketing Plan"
  end

  def example_marketing_strategy
    @title = "Example marketing strategy"
  end

  def best_marketing_strategy
    @title = "Best marketing strategy"
  end
  
  def add_to_email_list
    @hide_email_signup_form = true
    @ip = InterestedParty.new(:email => params[:email])
    
    UserMailer.thank_you_interested_party(@ip.email, root_url).deliver
    if @ip.save
      flash[:success] = "How cool are you?!?  We're excited and we'll drop you a note at #{params[:email]} when it's ready."
    else
      flash[:error] = "Something went wrong...argh...we didn't get to save your email."
    end
    
    respond_to do |format|
      format.html 
    end
    
  end
end
