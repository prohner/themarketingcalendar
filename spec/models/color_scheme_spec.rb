require 'spec_helper'

describe ColorScheme do
  before { @color_scheme = ColorScheme.new(name: "black on white", foreground: "black", background: "white") }
  
  subject { @color_scheme }
  
  it { should respond_to(:foreground) }
  it { should respond_to(:background) }
  it { should respond_to(:name) }

  describe "when name is not present" do
    before { @color_scheme.name = "  " }
    it { should_not be_valid }
  end
end
