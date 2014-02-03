class CalendarShareController < ApplicationController
  before_action :authenticate_user!, except: [:share_calendars_signup]

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
    @emails = params[:email].split(',').uniq
    @calendar_descriptions = []
    owner = current_user
    
    @emails.each do |email|
      email.strip!
      # puts "Invite #{email} to"
      partner = User.find_by_email(email)
      category_group_ids.each do |category_group_id|
        category_group = CategoryGroup.find_by_id(category_group_id)

        unless category_group.nil?
          # puts "  Category_group=#{category_group.description}" 
          @calendar_descriptions << category_group.description
          
          if partner.nil?
            partner = User.create!(:email => email, 
                        :first_name => User.default_value_for_empty_name,
                        :last_name => User.default_value_for_empty_name, 
                        :status => 'invited',
                        :password => User.default_value_for_password,
                        :password_confirmation => User.default_value_for_password)
          end
          
          share = Share.create(:owner => owner, :partner => partner, :category_group => category_group)

          UserMailer.shared_calendar_invitation(share, request.original_url).deliver
        end
        
      end
    end
  end
  
  def share_calendars_signup
    @share = Share.find_by_uuid(params[:u])
    puts "MARK 1"
    if @share.nil?
      puts "MARK 2"
      flash[:notice] = "Oh geez, we looked but couldn't find the invitation to share."
    else
      puts "MARK 3"
      sign_in @share.partner
    end
  end
end
