require 'spec_helper'

describe ColorScheme do
  before { @color_scheme = ColorScheme.new(foreground: "black", background: "white") }
  
  subject { @color_scheme }
  
  it { should respond_to(:foreground) }
  it { should respond_to(:background) }
  it { should respond_to(:name) }

end
