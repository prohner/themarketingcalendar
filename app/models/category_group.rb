# == Schema Information
#
# Table name: category_groups
#
#  id              :integer          not null, primary key
#  description     :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  color_scheme_id :integer
#  user_id         :integer
#

class CategoryGroup < ActiveRecord::Base
  has_many :categories
  belongs_to :color_scheme
  belongs_to :user
  has_many :shares
  
  default_scope { order('description') }
  
  def list_of_invited_partner_names
    partner_names = []
    shares.each do |s|
      partner_names << s.partner.full_name
    end
    partner_names
  end
end
