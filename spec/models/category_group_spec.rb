require 'spec_helper'

describe CategoryGroup do
  before { @category_group = CategoryGroup.new(description:"desc") }
  
  subject { @category_group }
  
  it { should respond_to(:description) }
  it { should respond_to(:color_scheme) }
  it { should respond_to(:categories) }

end
