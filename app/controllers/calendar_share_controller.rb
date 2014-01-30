class CalendarShareController < ApplicationController
  before_action :verify_user_is_signed_in_or_redirect

  def choose_calendar
    @category_groups = current_user.all_category_groups
  end

  def choose_user
    @category_group_ids = params[:category_groups]
    @category_group_descriptions = []
    @category_group_ids.each do |id|
      cg = CategoryGroup.find(id)
      @category_group_descriptions << cg.description
    end
  end
  
  def share_calendars
    category_group_ids = params[:i].split(' ')
    emails = params[:email].split(',').uniq
    owner = current_user
    
    emails.each do |email|
      puts "Invite #{email} to"
      partner = User.find_by_email(email)
      category_group_ids.each do |category_group_id|
        category_group = CategoryGroup.find_by_id(category_group_id)

        unless category_group.nil?
          puts "  Category_group=#{category_group.description}" 
          
          if partner.nil?
            partner = User.create!(:email => email, 
                        :first_name => 'tbd',
                        :last_name => 'tbd', 
                        :status => 'invited',
                        :password => 'should_be_in_secret_initializer',
                        :password_confirmation => 'should_be_in_secret_initializer')
          end
          
          share = Share.create(:owner => owner, :partner => partner, :category_group => category_group)

          UserMailer.shared_calendar_invitation(share, request.original_url).deliver
        end
        
      end
    end
  end
  
  def share_calendars_signup
    @share = Share.find_by_uuid(params[:u])
    if @share.nil?
      flash[:notice] = "Oh geez, we looked but couldn't find the invitation to share."
    else
      sign_in @share.partner
    end
  end
end
