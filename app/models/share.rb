# == Schema Information
#
# Table name: shares
#
#  id                :integer          not null, primary key
#  owner_id          :integer
#  partner_id        :integer
#  category_group_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  uuid              :string(255)
#  user_type         :integer
#

class Share < ActiveRecord::Base
  before_validation :default_values
  belongs_to :owner, :class_name => "User", inverse_of: :shares
  belongs_to :partner, :class_name => "User", inverse_of: :partners
  belongs_to :category_group, :class_name => "CategoryGroup"
  
  validates :owner, 
            :presence   => true
  validates :partner, 
            :presence   => true
  validates :category_group, 
            :presence   => true
  validates :uuid,
            :presence   => true
  validate :owner_is_different_from_partner

  validates_inclusion_of :user_type, :in => User.user_type_values
  
  def owner_is_different_from_partner
    return if owner.nil? or partner.nil?
    if owner.id == partner.id
      errors.add(:owner, "owner and partner cannot be the same")
    end
  end
  
  private
  def default_values
     self.uuid ||= SecureRandom.uuid
  end
  
end
