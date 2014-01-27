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

require 'spec_helper'

describe CategoryGroup do
  before { @category_group = CategoryGroup.new(description:"desc") }
  
  subject { @category_group }
  
  it { should respond_to(:description) }
  it { should respond_to(:color_scheme) }
  it { should respond_to(:categories) }

end
