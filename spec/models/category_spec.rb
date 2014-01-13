require 'spec_helper'

describe Category do
  before { @category = Category.new(description:"desc") }
  
  subject { @category }
  
  it { should respond_to(:description) }
  it { should respond_to(:color_scheme) }
end
